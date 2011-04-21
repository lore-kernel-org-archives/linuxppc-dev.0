Return-Path: <B07421@freescale.com>
Date: Thu, 21 Apr 2011 14:35:42 -0500
From: Scott Wood <scottwood@freescale.com>
To: Meador Inge <meador_inge@mentor.com>
Subject: Re: [PATCH 1/2] powerpc: document the FSL MPIC message register
	binding
Message-ID: <20110421143542.68971b33@schlenkerla.am.freescale.net>
In-Reply-To: <4DB084F6.4060103@mentor.com>
References: <1303232375-25014-1-git-send-email-meador_inge@mentor.com>
	<1303232375-25014-2-git-send-email-meador_inge@mentor.com>
	<20110419125214.560f4b99@schlenkerla.am.freescale.net>
	<4DADD3D2.6070805@mentor.com>
	<20110419133336.46d8566f@schlenkerla.am.freescale.net>
	<4DB084F6.4060103@mentor.com>
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

On Thu, 21 Apr 2011 14:26:46 -0500
Meador Inge <meador_inge@mentor.com> wrote:

> Hmmm ...  In the MPC8572E and P1022DS manuals I don't see the terminology
> group used for message registers.

I was looking at the P4080 manual, which does use it.  It looks like some
other chip manuals just use MSGR0-MSGR7.

> If you feel like group is a more idiomatic term, I can change it.

Since the docs aren't consistent, I don't really have a strong opinion
here.  Just make clear in the binding what you're referring to.

-Scott
