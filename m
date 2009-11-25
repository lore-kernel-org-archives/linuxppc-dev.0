Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Nathan Fontenot <nfont@austin.ibm.com>, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] Kernel DLPAR infrastructure
In-reply-to: <31581.1259115310@neuling.org>
References: <4B0C8B45.6080804@austin.ibm.com> <4B0C8CE3.4010207@austin.ibm.com>
	<31581.1259115310@neuling.org>
Date: Wed, 25 Nov 2009 14:03:45 +1100
Message-ID: <6799.1259118225@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



In message <31581.1259115310@neuling.org> you wrote:
> 
> 
> In message <4B0C8CE3.4010207@austin.ibm.com> you wrote:
> > This patch provides the kernel DLPAR infrastructure in a new filed named
> > dlpar.c.  The functionality provided is for acquiring and releasing a resou
rc
> e
> > from firmware and the parsing of information returned from the
> > ibm,configure-connector rtas call.  Additionally this exports the pSeries
> > reconfiguration notifier chain so that it can be invoked when device tree 
> > updates are made.
> > 
> > Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com> 
> 
> These look like they got white space munged somewhere...

Gah, sorry, they are fine

Mikey
