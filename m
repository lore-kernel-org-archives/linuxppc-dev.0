Message-ID: <0509218DDAD7D6118055006008F6D5F6A1E371@postal.viasat.com>
From: "Pagnotta, Chris" <chris.pagnotta@viasat.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Support for ELDK 2.0.2 On Sid?
Date: Thu, 7 Nov 2002 16:56:46 -0800 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am having trouble getting ELDK 2.0.2 to install correctly on Debian
release "sid".
It seems that after I change the permissions on the scripts + exe to

for file in \
        tools/bin/rpm \
        tools/usr/lib/rpm/rpmd \
        install \
        ELDK_MAKEDEV \
        ELDK_FIXOWNER
do
chmod +x eldk-ppc-linux-x86/2.0.2/$file

note: rpmdb has changed to rpmd in ELDK 2.0.2

Then I run the "install -d /almost/there ppc_4xx" and I get the following
ouput

Do you really want to install into /home/public/bin/cross directory[y/n]?: y

Installing cross RPMs

Preparing...                ###########################################
[100%]

$

gcc,gbd,etc are not created in  /almost/there. I do however have rpm
installed in
the /almost/there/bin directory.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
