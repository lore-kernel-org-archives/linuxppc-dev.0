Message-ID: <386028EE.8AA33490@nibh.go.jp>
Date: Wed, 22 Dec 1999 10:27:12 +0900
From: Ichiro Hieda <hieda@nibh.go.jp>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
CC: hieda@nibh.go.jp
Subject: Comtrol RocketPort porting
Content-Type: text/plain; charset=iso-2022-jp; x-mac-type="54455854"; x-mac-creator="4D4F5353"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I have been debugging RocketPort driver to LinuxPPC for nearly a month.
I would like to use it for a ham radio server which needs serial ports.

Today, as far as I believe, the driver finally works on my PowerMac.

Configuration for debugging
      Comtrol Rocketport PCI Octacable (8port)
              Firmware revision F
       Apple PowerMacintosh G4 400
       LinuxPPC 1999 Q3 (very latest: download on 20 Dec 1999 from
cdrom.com)
       Kernel 2.2.14pre9
       Ted's alpha code, comtrol-1.17

Limitation
       Tested only with minicom under above configuration.
       Tested only port 0, 1, 3 and 7
       The response from minicom seems a little dull if I compare it to
x86 environment.
       Auto channel number detection fails. Fixed to 8 channels.

My modification ended up only a few things (most of them are endien
stuff), but the source codes I am working are currently very messy. I
will clean up them and do a little more debugging and would like to
place on my web site.

For someone who can't wait, I place the source codes I am working at
http://www.aist.go.jp/NIBH/~b0514/Linux/comtrol/

Best regards,
Ichiro Hieda
hieda@nibh.go.jp


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
