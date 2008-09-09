Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 614F0DDF15
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  9 Sep 2008 19:37:29 +1000 (EST)
To: "VenkataKrishna" <venkatakrishnap@vrindatech.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: ELDK
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <20080909064333.56D4BDDF07@ozlabs.org>
References: <20080909064333.56D4BDDF07@ozlabs.org>
Date: Tue, 09 Sep 2008 11:37:26 +0200
Sender: wd@denx.de
Message-Id: <20080909093726.A7B532489D@gemini.denx.de>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear "VenkataKrishna",

In message <20080909064333.56D4BDDF07@ozlabs.org> you wrote:
> 
> I followed your sequence which is I show below. But I got problem shown
> below. Plz Suggest me. How can I solve this one.

You might want to post ELDK related question to the ELDK mailing
list. They are off topic here.

> make: ppc_6xx-gcc: Command not found

Obviously you have forgottem to add the ELDK directories to your PATH.
Please make sure to read the manual (DULG).


Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
I used to be indecisive, now I'm not sure.
