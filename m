Return-Path: <anton@samba.org>
Date: Thu, 18 Jul 2013 14:00:45 +1000
From: Anton Blanchard <anton@samba.org>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] module: ppc64 module CRC relocation fix causes perf issues
Message-ID: <20130718140045.6794ecd5@kryten>
In-Reply-To: <1374019697.8183.351@snotra>
References: <1374014420.8183.342@snotra> <1374019445.19894.403.camel@pasglop>
 <1374019697.8183.351@snotra>
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

> What specifically should I do to test it?

Could you double check perf annotate works? I'm 99% sure it will but
that is what was failing on ppc64.

Anton
