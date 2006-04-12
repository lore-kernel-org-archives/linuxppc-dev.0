Return-Path: <glikely@gmail.com>
Received: from nproxy.gmail.com (nproxy.gmail.com [64.233.182.188])
	by ozlabs.org (Postfix) with ESMTP id 3924F67CB6
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 13 Apr 2006 07:50:55 +1000 (EST)
Received: by nproxy.gmail.com with SMTP id m19so1039854nfc
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Apr 2006 14:50:54 -0700 (PDT)
Message-ID: <528646bc0604121450t2467be31med5e97fc14077313@mail.gmail.com>
Date: Wed, 12 Apr 2006 15:50:54 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Vincent Winstead" <vwinstead@yahoo.com>
Subject: Re: Xilinx Virtex-2 PRO FPGA ppc 405 on ML310 board
In-Reply-To: <20060412214613.10018.qmail@web52004.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <528646bc0604121252r48d93ac0ubf7d60116815c1b5@mail.gmail.com>
	<20060412214613.10018.qmail@web52004.mail.yahoo.com>
Cc: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 4/12/06, Vincent Winstead <vwinstead@yahoo.com> wrote:
>
> Very Interesting.  Now I know what they were talking about on the sites t=
hat
> go through how to install the linux kernel onto the ML300.  because in th=
ose
> method  walk-throughs they show which options you should choose when doin=
g a
> "make menuconfig" and there are specific ones regarding Xilinx but I neve=
r
> saw these when doing configurations of what you call mainline versions of
> the linux kernel.

>   So, when you say that the "The linuxppc-2.4 tree is
> special because it's one of the trees that actually has the ML300
> patches integrated", are you implying that you could put these patches in=
to
> the system on your own if you wanted to?

Of course you can

>  You're not talking about the board
> support package are you?

As far as you can apply the concept of BSP to Linux; yes I am.  The
patches provide the code required to work on an ML300 ref design...
drivers and initialization code specifically

g.

--
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
(403) 399-0195
