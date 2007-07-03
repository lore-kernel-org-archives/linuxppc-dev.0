Return-Path: <sprasad@bivio.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: insmod - Bad address
Date: Mon, 2 Jul 2007 17:13:13 -0700
Message-ID: <D83235F0F3C86D4D889D8B9A0DA8C6D7808797@corpexc01.corp.networkrobots.com>
From: "Siva Prasad" <sprasad@bivio.net>
To: <linuxppc-dev@ozlabs.org>, <linuxppc-embedded@ozlabs.org>,
	<linux-kernel-digest@lists.us.dell.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

When I try to do insmod or modprobe, I get "Bad Address". I don't
exactly understand what this is, and how to take care of this.

Any ideas. Appreciate any help.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
modprobe: FATAL: Error inserting binfmt_misc
(/lib/modules/2.6.15-9bvoem50npc3/kernel/fs/binfmt_misc.ko): Bad address

modprobe: FATAL: Error running install command for binfmt_misc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D

Thanks
Siva
