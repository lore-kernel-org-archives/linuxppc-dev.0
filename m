Return-Path: <pnasrat@redhat.com>
Subject: Re: [PATCH 1/1] determine last ext3 LBA to fix wild LBA reads - v3
From: Paul Nasrat <pnasrat@redhat.com>
To: Doug Maxey <dwm@enoyolf.org>
In-Reply-To: <1121.1167886652@bebe.enoyolf.org>
References: <1121.1167886652@bebe.enoyolf.org>
Content-Type: text/plain
Date: Thu, 15 Feb 2007 12:25:26 +0000
Message-Id: <1171542327.3387.70.camel@enki.eridu>
Mime-Version: 1.0
Cc: Linux PowerPC List <linuxppc-dev@ozlabs.org>, yaboot-devel@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-01-03 at 22:57 -0600, Doug Maxey wrote:
> The issue seen in the current code is linux_read_blk() is
> (apparently) looking at the alternate offsets for all possible
> superblocks.  As yaboot scans each partition for all fs types, until
> it finds the appropriate signature, when searching the ext fs, libext2
> appears to calculate some blocks to read that may be 10x the size of
> the actual disk.

Thanks for this I've commited and it'll be in 1.3.14 shortly.

Sorry for the delay.

Paul
