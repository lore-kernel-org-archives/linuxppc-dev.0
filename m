Return-Path: <glikely@secretlab.ca>
Message-ID: <fa686aa40707191243wb4ce9c1n86002405c5d01bab@mail.gmail.com>
Date: Thu, 19 Jul 2007 13:43:17 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Scott Wood" <scottwood@freescale.com>
Subject: Re: [PATCH 3/4] mpc8349emitx: Add chosen node for default stdout path
In-Reply-To: <469FB47D.4030009@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <20070719183415.7458.42622.stgit@trillian>
	<20070719183734.7458.83695.stgit@trillian>
	<469FB47D.4030009@freescale.com>
Cc: linuxppc-dev@ozlabs.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 7/19/07, Scott Wood <scottwood@freescale.com> wrote:
> Grant Likely wrote:
> > From: Grant Likely <grant.likely@secretlab.ca>
> >
> > To boot from a cuImage requires the device tree to have a
> > linux,stdout-path property in the chosen node.  This patch adds it
> > to the .dts files.
>
> This will break many current u-boots, as they blindly add a /chosen node
> regardless of whether one already exists.

That really should be fixed then.  In the meantime; I'll resubmit the
patch to add the chosen node; but with it commented out.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
