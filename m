Return-Path: <wd@denx.de>
To: "debora liu" <deboralh@sinovee.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 14 Nov 2005 13:30:10 +0800."
	<200511141320468.SM01124@debora-liu>
Date: Mon, 14 Nov 2005 10:38:15 +0100
Sender: wd@denx.de
Message-Id: <20051114093815.791A9352568@atlas.denx.de>
Cc: Linuxppc-embedded <Linuxppc-embedded@ozlabs.org>
Subject: Re: name created by rpmbuild 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <200511141320468.SM01124@debora-liu> you wrote:
> 
> I'm using rpmbuild, but it creat rpm packet name is "NAME-ppc_8xx-VERSION-RELEASE.ppc.rpm",
> I think it should is "NAME-VERSION-RELEASE.ppc.rpm", true?
> I use native rpmbuild on my board with eldk-3.1.1 PPC8xx NFS root.

You asked the same question just two days ago. Why do you ask  again?
I replied:

------- Forwarded Message

Date:    Sat, 12 Nov 2005 13:52:56 +0100
From:    Wolfgang Denk <wd@denx.de>
To:      deboralh@fel.com.cn
Subject: Re: packet name created by rpmbuild 

In message <200511121759781.SM00928@RavProxy> you wrote:
> >
> Sorry, this is text

Thanks.

> I'm using rpmbuild, but it creat rpm packet name is "NAME-ppc_8xx-VERSION-REL
EASE.ppc.rpm",
> I think it should is "NAME-VERSION-RELEASE.ppc.rpm", true?

No, wrong. "*.ppc.rpm" indicates a "standard"  RPM  from  some  Linux
distribution,  like  a  Fedora Core PowerPC RPM. Such an RPM will NOT
run on your MPC8xx system, and your ppc_8xx created RPM will not  run
on  a  Fedora Core PowerPC system. Differences are caused for example
by support for a FPU and adjustment for different cache  line  sizes.
To  avoid confusion, MPC8xx specific RPMs are created using a special
name which makes clear that they are compatible with the  ELDK  RPMs,
but not with other PowerPC RPMs.

> I use native rpmbuild on my board with eldk-3.1.1 PPC8xx NFS root.

Native rpmbuild and cross rpmbuild are compatible  with  each  other,
but not with RPMs from other PowerPC Linux distributions.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Where people stand is not as important as which way they face.
        - Terry Pratchett & Stephen Briggs, _The Discworld Companion_

------- End of Forwarded Message
