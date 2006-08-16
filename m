Return-Path: <paubert@iram.es>
Received: from gra-lx1.iram.es (gra-lx1.iram.es [150.214.224.41])
	by ozlabs.org (Postfix) with ESMTP id 6DAA267A3F
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Aug 2006 20:39:58 +1000 (EST)
From: Gabriel Paubert <paubert@iram.es>
Date: Wed, 16 Aug 2006 12:15:27 +0200
To: Paul Mackerras <paulus@samba.org>
Subject: Re: Who cares about PReP?
Message-ID: <20060816101527.GA21865@iram.es>
References: <17622.58559.879330.496619@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17622.58559.879330.496619@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Aug 07, 2006 at 04:59:11PM +1000, Paul Mackerras wrote:
> I started looking at moving the PReP code over to arch/powerpc.  I am
> struck by how many ifdefs there are in there to set things up for
> particular individual PReP implementations.  We can do better than
> that, I'm sure, 

hopefully.

> but the issue becomes one of testing.  The only PReP I
> have here is an RS/6000 43p-140.
> 
> Who else has a PReP system and would be willing to do some testing and
> debugging?  If so, what sort of PReP is it?

We are using 20+ MVME boards here so I am interested, 
MVME2400/2600/2700 to be precise. 

Right now I can test patches and not much more, I'm really 
short of time and fighting other issues. Among them my PB 
G4 from last December just completely failed (and Apple 
told me to bring it to a shop in this city that is closed 
for holidays until ... September 4th).


	Regards,
	Gabriel
