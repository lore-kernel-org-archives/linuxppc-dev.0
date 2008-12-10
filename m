Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18752.14748.408940.386056@cargo.ozlabs.ibm.com>
Date: Thu, 11 Dec 2008 08:50:20 +1100
From: Paul Mackerras <paulus@samba.org>
To: David Howells <dhowells@redhat.com>
Subject: Re: Re[2]: [PATCH] fork_init: fix division by zero
In-Reply-To: <5545.1228914404@redhat.com>
References: <1795455197.20081210132912@emcraft.com>
	<200812092044.40649.yur@emcraft.com>
	<Pine.LNX.4.64.0812100944080.25126@vixen.sonytel.be>
	<503391615.20081210130113@emcraft.com>
	<20081210101745.GG28946@ZenIV.linux.org.uk>
	<5545.1228914404@redhat.com>
Cc: Wolfgang Denk <wd@denx.de>, Detlev Zundel <dzu@denx.de>,
	linux-kernel@vger.kernel.org, Milton Miller <miltonm@bga.com>,
	linuxppc-dev@ozlabs.org, Al Viro <viro@ZenIV.linux.org.uk>,
	Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	Ilya Yanok <yanok@emcraft.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Howells writes:

> Ummm...  On powerpc, I believe rotate-left would be a division as it does the
> bit-numbering and the bit direction the opposite way to more familiar CPUs
> such as x86.

No.  :)

"Left" and "right" are relative to the way those of us humans in the
Western European cultural tradition write numbers, which is
big-endian.  So rotate-left always moves bits towards the more
significant end of the word.

Paul.
