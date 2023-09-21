FROM zekfad/flutter-builder:latest

WORKDIR /root

# RUN chmod 400 -R /root/.ssh

RUN git config --global user.name "Flutter Developer"
RUN git config --global user.email flutter@dev.dev
RUN git config --global core.ignorecase false
RUN git config --global pull.rebase true
RUN git config --global core.autocrlf false
RUN git config --global core.symlinks true

COPY ./scripts /root/scripts

RUN chmod -R +x /root/scripts/*

# ENV REPO_KEY=/root/ssh_key
# ENV REPO_URL=git@github.com/test/test.git
# ENV REPO_BRANCH=master

SHELL [ "/bin/bash", "-c" ]
CMD source /root/scripts/fix-ssh-key-perms.sh \
	&& /root/scripts/pull-repo.sh /root/repo \
	&& source /root/scripts/fix-ssh-key-perms.sh remove-copy \
	&& cd /root/repo \
	&& flutter build apk \
	&& cp -r build/app/outputs/flutter-apk/* /root/apk/
