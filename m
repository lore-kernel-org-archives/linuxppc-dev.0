Return-Path: <sven@powerlinux.fr>
Date: Wed, 22 Aug 2007 15:04:33 +0200
To: Meelis Roos <mroos@linux.ee>
Subject: Re: How to port PReP to arch/powerpc?
Message-ID: <20070822130433.GA32276@powerlinux.fr>
References: <Pine.SOC.4.64.0708221444510.5639@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.SOC.4.64.0708221444510.5639@math.ut.ee>
From: Sven Luther <sven@powerlinux.fr>
Cc: linuxppc-dev@ozlabs.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 22, 2007 at 02:50:07PM +0300, Meelis Roos wrote:
> It seems no one cares for arch/ppc any more but the move to powerpc was 
> not finished completely (PReP subarch was not migrated but sees users, I 
> do not know about the user base of the other subarches). So I have been 
> thinking about migrating PReP support to arch/powerpc myself since I use 
> it.
> 
> Any general guidelines or specific hints about that? I have looked 
> around in the code and some pieces are clearly PReP specific (setup, 
> pci, boot) but others seem wuite a bit mixed up with other subarches.

I don't have much time for this right now, but i am interested in
helping out in a PReP arch/powerpc port, as this would allow debian to
drop the arch/ppc -prep flavour. I have both a motorola and an IBM PReP
box here to play with and test.

Friendly,

Sven Luther
