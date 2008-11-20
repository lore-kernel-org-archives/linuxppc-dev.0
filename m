Return-Path: <glikely@secretlab.ca>
Received: from rn-out-0910.google.com (rn-out-0910.google.com [64.233.170.187])
	by ozlabs.org (Postfix) with ESMTP id E8115DDDEC
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Nov 2008 02:49:16 +1100 (EST)
Received: by rn-out-0910.google.com with SMTP id j40so455858rnf.16
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Nov 2008 07:49:15 -0800 (PST)
Message-ID: <fa686aa40811200749xd9f8701ud6ee9b77b4c21001@mail.gmail.com>
Date: Thu, 20 Nov 2008 08:49:15 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
To: gianfranco.casanova@alice.it, linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: Re: R: USB on lite5200 does not work.
In-Reply-To: <47602D18F269934AB73B7E550804A1E00213796F@FBCMST09V03.fbc.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <47602D18F269934AB73B7E550804A1E00213796C@FBCMST09V03.fbc.local>
	<fa686aa40811200656g783947f5l609650b707c6c883@mail.gmail.com>
	<47602D18F269934AB73B7E550804A1E00213796F@FBCMST09V03.fbc.local>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Nov 20, 2008 at 8:33 AM,  <gianfranco.casanova@alice.it> wrote:
> I Grant
> I would but I cannot move up to an other kernel, project constraints.
>
> Complement of INFO:
> using a lite5200EVB USB works. using our board (kernel modified for our
> board), USB does not work.
>
> Have you got some ideas? I can send you what file have been modified (a
> couple).

Check your settings in the port config register.

Also, please remember to CC: the mailing list when replying to questions.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
