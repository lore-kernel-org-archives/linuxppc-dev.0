Date: Mon, 25 Sep 2000 09:03:19 -0400
Subject: latest nvsetenv?
From: johnathan spectre <jspectre@lords.com>
To: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Message-ID: <B5F4C557.2241%jspectre@lords.com>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


hi everyone,

I'm having some problems with ybin, one of them being a complaint that I
don't have the latest version of nvsetenv.

Can someone point me out to where I can find the latest version? I looked on
a few sites and search engines and can't find it.

Thanks!

-js

ps. if anyone can help with ybin I'd appreciate it, I'm getting the
following error when it tries to copy to my boot partition:

/tmp # ybin -v
ybin: Warning: Incompatible version of `nvsetenv', nvram will not be updated
ybin: Finding OpenFirmware device path to `/dev/hda8'...
ybin: Finding OpenFirmware device path to `/dev/hda4'...
ybin: Finding OpenFirmware device path to `/dev/hda16'...
ybin: Checking /dev/hda8 for valid HFS filesystem...
ybin: Copying /usr/local/lib/yaboot/yaboot to /dev/hda8...
hcopy: Current HFS directory "linuxppc::" no longer exists
hcopy: "/usr/local/lib/yaboot/yaboot": can't find parent directory
(Input/output error)
ybin: An error occured while copying files to /dev/hda8


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
