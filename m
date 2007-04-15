Return-Path: <glikely@gmail.com>
Message-ID: <528646bc0704150720s790218a9od41c91bb623d2f95@mail.gmail.com>
Date: Sun, 15 Apr 2007 08:20:31 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Dale Farnsworth" <dale@farnsworth.org>
Subject: Re: [PATCH 1/5] [PPC] Rework Kconfig dependancies for Xilinx Virtex
	ppc405 platform
In-Reply-To: <20070415104819.6709.qmail@farnsworth.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <1176622062492-git-send-email-grant.likely@secretlab.ca>
	<11766220692537-git-send-email-grant.likely@secretlab.ca>
	<20070415104819.6709.qmail@farnsworth.org>
Cc: Linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 15 Apr 2007 03:48:19 -0700, Dale Farnsworth <dale@farnsworth.org> wrote:
> In article <11766220692537-git-send-email-grant.likely@secretlab.ca> you write:
> >  config XILINX_VIRTEX_II_PRO
> >       bool
> > -     depends on XILINX_ML300
> > -     default y
> > +     select XILINX_VIRTEX
> > +     default n
>
> Since these variables are not user selectable, it's better to
> remove the "default n", so they don't show up when not selected.

Ah, okay.  I didn't know that.  Thanks.  I'll make that change.
g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
