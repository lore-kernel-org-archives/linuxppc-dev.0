Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 96781DDDF2
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Sep 2007 06:07:56 +1000 (EST)
To: Babarovic Ivica <ivica.babarovic@asist.si>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Which 2.6 kernel for MPC5200
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 10 Sep 2007 19:10:53 +0200."
	<46E57A9D.2020506@asist.si>
Date: Tue, 11 Sep 2007 22:07:54 +0200
Sender: wd@denx.de
Message-Id: <20070911200754.87407247DB@gemini.denx.de>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <46E57A9D.2020506@asist.si> you wrote:
> 
> What kernel should I get/pull for MPC5200 clone board.
> I've been away from coding on mpc5200 for quite some time now.
> I've read some archives from ML.
> Git repo on Sylvain Munauts url:
> http://gitbits.246tNt.com/gitbits/linux-2.6-mpc52xx.gitpage
> isn't working. Nothing on http://*git*.secretlab.ca/cgi-bin/*gitweb*.cgi
> <http://git.secretlab.ca/cgi-bin/gitweb.cgi> to.

We have working support for  the  MPC5200  (based  on  Sylvain's  and
Grant's)  code  in  our  linux-2.6-denx  repository, at least for the
lite5200b and TQM5200 boards; I recommend to  stick  with  commit  ID
85ab69c5  = tag DENX-2007-08-30-1748 at the moment, as the 2.6.23-rc5
coe is not completely tested yet. [Well, actually *all* this is  work
in progress...]

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
There are always alternatives.
	-- Spock, "The Galileo Seven", stardate 2822.3
