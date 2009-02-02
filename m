Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 90337DDF69
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Feb 2009 10:58:15 +1100 (EST)
To: Grzegorz Bernacki <gjb@semihalf.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH] Add support for the digsy MTC board.
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <49872268.10003@semihalf.com>
References: <1233329630876-git-send-email-gjb@semihalf.com>
	<fa686aa40901300859t4da76ce3hf943adc48abb9b9c@mail.gmail.com>
	<4986EC33.9000600@semihalf.com> <49871C8C.8030200@matrix-vision.de>
	<49872268.10003@semihalf.com>
Date: Tue, 03 Feb 2009 00:58:11 +0100
Message-Id: <20090202235811.AD8E78322908@gemini.denx.de>
Cc: Andre Schwarz <andre.schwarz@matrix-vision.de>, tech-denx@semihalf.com,
	Detlev Zundel <dzu@denx.de>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Dear Grzegorz Bernacki,

In message <49872268.10003@semihalf.com> you wrote:
> 
> > We also had this kind of problem - after feeding some nfs options it
> > worked :
> > 
> > rsize=8192,wsize=8192,soft,intr,tcp,nolock
> 
> it seems that it helps.

Can you please find out which of these changes is the relevant part?

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
There comes to all races an ultimate crisis which  you  have  yet  to
face  ....  One  day  our  minds became so powerful we dared think of
ourselves as gods.
	-- Sargon, "Return to Tomorrow", stardate 4768.3
