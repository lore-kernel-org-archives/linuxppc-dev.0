Message-ID: <3D47CD6E.8080200@icn.siemens.de>
Date: Wed, 31 Jul 2002 13:43:42 +0200
From: Steffen Rumler <Steffen.Rumler@icn.siemens.de>
MIME-Version: 1.0
To: linuxppc <linuxppc-embedded@lists.linuxppc.org>
Subject: RPM: excludepath broken
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I'm actually using RPM 3.0.6.

I want to exclude distinct files for installation.

When I run the following command:

   rpm -ihvv --excludepath /usr/X11R6/lib  calctool.rpm
   ...
   D: installing binary packages
   D: getting list of mounted filesystems
   D: excluding directory /usr/X11R6/lib/
   ...
   D:    file: /usr/X11R6/bin/calctool action: create
   D:    file: /usr/X11R6/lib/calctool.help action: create
   D:    file: /usr/X11R6/man/man1/calctool.1.gz action: create
   D: running preinstall script (if any)
   calctool                    #################################################
   ...
   D: running postinstall scripts (if any)

it seems --excludepath does not work ?
/usr/X11R6/lib/calctool.help was created.


Steffen

--


--------------------------------------------------------------

Steffen Rumler
ICN ON PNE SB 4
Siemens AG
Hofmannstr. 51                 Email: Steffen.Rumler@icn.siemens.de
D-81359 Munich                 Phone: +49 89 722-44061
Germany                        Fax  : +49 89 722-36703

--------------------------------------------------------------


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
