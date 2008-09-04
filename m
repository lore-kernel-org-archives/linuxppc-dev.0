Return-Path: <sebastien.chretien.enseirb@gmail.com>
Received: from plan.enseirb.fr (plan.enseirb.fr [147.210.18.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BB6C8DDEDE
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Sep 2008 06:20:12 +1000 (EST)
Message-ID: <48C042C7.4090900@gmail.com>
Date: Thu, 04 Sep 2008 22:19:19 +0200
From: =?UTF-8?B?U8OpYmFzdGllbiBDaHLDqXRpZW4=?=
	<sebastien.chretien.enseirb@gmail.com>
MIME-Version: 1.0
To: benh@kernel.crashing.org
Subject: Re: Trace
References: <319b0ac50809010216jac3ae30r9260699abde6535@mail.gmail.com>	
	<929D3CED81F34E43887A393170D66FB926B259@GBRSUN01MS002.eu.xerox.net>	
	<319b0ac50809010525w7451ef92m5aaf6fd5f5a8958e@mail.gmail.com>	
	<929D3CED81F34E43887A393170D66FB926B40F@GBRSUN01MS002.eu.xerox.net>	
	<929D3CED81F34E43887A393170D66FB926B41A@GBRSUN01MS002.eu.xerox.net>	
	<48BC195F.4070505@gmail.com> <1220314383.13010.62.camel@pasglop>	
	<48BCCB6D.5040209@fr.thalesgroup.com>
	<1220334314.13010.89.camel@pasglop>	
	<319b0ac50809020034m12b4d57cj1fdf31f3282935e6@mail.gmail.com>
	<1220343590.13010.118.camel@pasglop>
In-Reply-To: <1220343590.13010.118.camel@pasglop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: =?UTF-8?B?U8OpYmFzdGllbiBDSFJFVEk=?=,
	=?UTF-8?B?U8OpYmFzdGllbiBDaHLDqXRpZW4=?=
	<sebastien.chretien.enseirb@gmail.com>, "Jenkins,
	Clive" <Clive.Jenkins@xerox.com>, linuxppc-dev@ozlabs.org,
	=?UTF-8?B?RU4=?= <sebastien.chretien@fr.thalesgroup.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


I followed your advice : I used the UART layer.
It is easier.
Thanks


Benjamin Herrenschmidt a écrit :
> On Tue, 2008-09-02 at 09:34 +0200, Sébastien Chrétien wrote:
>   
>> ok is it a bad way to write a tty driver ? why ?
>>     
>
> Not necessarily, it's just overkill. The UART layer handles a lot
> of stuff for you. The tty layer is tricky to get right.
>
> Cheers,
> Ben.
>
>
>   
