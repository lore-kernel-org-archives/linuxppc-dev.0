Return-Path: <B07421@freescale.com>
Date: Tue, 19 Apr 2011 13:33:36 -0500
From: Scott Wood <scottwood@freescale.com>
To: Meador Inge <meador_inge@mentor.com>
Subject: Re: [PATCH 1/2] powerpc: document the FSL MPIC message register
	binding
Message-ID: <20110419133336.46d8566f@schlenkerla.am.freescale.net>
In-Reply-To: <4DADD3D2.6070805@mentor.com>
References: <1303232375-25014-1-git-send-email-meador_inge@mentor.com>
	<1303232375-25014-2-git-send-email-meador_inge@mentor.com>
	<20110419125214.560f4b99@schlenkerla.am.freescale.net>
	<4DADD3D2.6070805@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: openmcapi-dev@googlegroups.com,
	Hollis Blanchard <hollis_blanchard@mentor.com>,
	devicetree-discuss@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 19 Apr 2011 13:26:26 -0500
Meador Inge <meador_inge@mentor.com> wrote:

> On 04/19/2011 12:52 PM, Scott Wood wrote:
> > On Tue, 19 Apr 2011 11:59:34 -0500
> > Meador Inge <meador_inge@mentor.com> wrote:
> > 
> >>  Aliases are of the form 'msgr-block<n>',
> >> +    where <n> is an integer specifying the block's number.  Numbers shall start
> >> +    at 0.
> > 
> > The hw docs refer to "group A" and "group B", not "block 0" and "block 1".
> > 
> > Plus, I'd put "mpic-" in the alias name.
> 
> Are you suggesting that the alias should be called: 'mpic-groupA',
> 'mpic-groupB', 'mpic-groupC', etc... ?

I was thinking something like "mpic-msgr-group-a", "mpic-msgr-group-b" --
though if you want to use numbers instead to more easily map to potential
APIs, that's OK.

-Scott
