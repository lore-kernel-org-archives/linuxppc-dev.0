Return-Path: <tmorrison@empirix.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: i2c-tools
Date: Wed, 11 Apr 2007 11:18:55 -0400
Message-ID: <BD261180E6D35F4D9D32F3E44FD3D9010745DE68@EMPBEDEX.empirix.com>
In-Reply-To: <EMPBEDEX14Ogddu5qE8000107c3@empbedex1.empirix.com>
References: <EMPBEDEX14Ogddu5qE8000107c3@empbedex1.empirix.com>
From: "Morrison, Tom" <tmorrison@empirix.com>
To: <ltib@nongnu.org>
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I am looking for a new i2c-tools package=20
that is newer than what is being distributed=20
with ltib:
=20
   <i2c_tools-2jun05.tar.gz>=20

It does not have i2cget in this package (and
I am finding i2cdump a little bit of overkill
for wanting to read just one byte/word.

Any advice would be greatly appreciated.

Tom

ps: I did try to get lm-sensors 2.9 - but there
were some compile problems (specifically it was=20
complaining about not finding 'sys/io.h' (when in=20
my kernel (2.6.11) the proper file is found=20
somewhere else (include/asm-ppc/io.h).


Thanks in advance

Tom Morrison
Principal S/W Engineer
Empirix, Inc (www.empirix.com)
tmorrison@empirix.com
