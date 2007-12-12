Return-Path: <sprasad@bivio.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: initrd - /dev 
Date: Tue, 11 Dec 2007 18:07:42 -0800
Message-ID: <D83235F0F3C86D4D889D8B9A0DA8C6D7011A7CC7@corpexc01.corp.networkrobots.com>
From: "Siva Prasad" <sprasad@bivio.net>
To: <linuxppc-dev@ozlabs.org>,
	<linuxppc-embedded@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I have a initrd image that I am trying to use on 8641D. When I mount it
on a regular PC (using mount -o loop <ramdisk file> <dir>), I can see
all the required files in /dev directory.

However, after loading the same <ramdisk file.gz> into the target board,
all the files in /dev is missing, making it not print any messages (as
/dev/console is also missing).

Why would the files in /dev just disappear after loading it, while it is
present when I normally mount it on a Linux PC.

I find this very strange and appreciate any clue that can lead to
resolution. I am willing to try out any thought you may have.

Thanks
Siva
