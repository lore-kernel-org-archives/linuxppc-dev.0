Return-Path: <benh@kernel.crashing.org>
Subject: Re: [MPC7448] machdep_calls
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: =?ISO-8859-1?Q?S=E9bastien_Chr=E9tien?=
	<sebastien.chretien.enseirb@gmail.com>
In-Reply-To: <319b0ac50808180145r44a1b64fhd09c038ce45bb206@mail.gmail.com>
References: <319b0ac50808180145r44a1b64fhd09c038ce45bb206@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Date: Mon, 18 Aug 2008 19:27:04 +1000
Message-Id: <1219051624.28339.39.camel@pasglop>
Mime-Version: 1.0
Cc: Linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2008-08-18 at 10:45 +0200, Sébastien Chrétien wrote:
> Hello,
> 
> I am developping a Linux for my PPC Board. I must write a
> define_machine structure (marchdep_calls). Where can I find some
> Information about functions of this structure ?

It isn't well documented unfortunately. Best is to look at what others
do... and then find your way through.

I agree somebody should write dome doco one day ... in the meantime,
feel free to ask questions here.

Cheers,
Ben.
