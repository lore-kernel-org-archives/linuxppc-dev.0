Return-Path: <anton@samba.org>
Date: Thu, 25 Jul 2013 08:34:27 +1000
From: Anton Blanchard <anton@samba.org>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] module: ppc64 module CRC relocation fix causes perf issues
Message-ID: <20130725083427.56e36010@kryten>
In-Reply-To: <1374274770.5357.33@snotra>
References: <20130718140045.6794ecd5@kryten>
	<1374274770.5357.33@snotra>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Neil Horman <nhorman@tuxdriver.com>, Rusty Russell <rusty@rustcorp.com.au>,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi Scott,

> I'm not really sure what it's supposed to look like when "perf  
> annotate" works.  It spits a bunch of unreadable[1]
> dark-blue-on-black assembly code at me, all with "0.00 :" in the left
> column.
> 
> Oh, wait -- some lines have "100.00 : " on the left, in  
> even-more-unreadable dark-red-on-black.
> 
> Apart from the annoying colors, is there anything specific I should
> be looking for?  Some sort of error message, or output that actually
> makes sense?

Thanks for testing! Ben, I think the patch is good to go.

Anton
