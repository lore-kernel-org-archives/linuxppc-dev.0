Return-Path: <wd@denx.de>
Received: from mailout10.sul.t-online.com (mailout10.sul.t-online.com
	[194.25.134.21]) by ozlabs.org (Postfix) with ESMTP id CFC3C68193
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 30 Aug 2005 18:21:31 +1000 (EST)
To: "JohnsonCheng" <JohnsonCheng@qnap.com.tw>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 30 Aug 2005 12:16:58 +0800."
	<20050830041704.3ECDE68166@ozlabs.org>
Date: Tue, 30 Aug 2005 10:21:10 +0200
Sender: wd@denx.de
Message-Id: <20050830082110.CC61D35258E@atlas.denx.de>
Cc: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: Cross compile krb5 issue for ppc 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <20050830041704.3ECDE68166@ozlabs.org> you wrote:
> 
> When I cross compile krb5-1.4.1 for ppc on x86, I got the following error
> message.
...
> Cannot test for constructor/destructor support when cross compiling

Yes, this is a very typical situation. Many packages are not  exactly
well-behaving  in  a  cross  environment,  so  you  need more or less
extensive tweaking.

> Do anybody can give me advice or tell me where to get krb5 library for ppc?

It's included with the ELDK.

Also, if you look at the ELDK's patches and spec files  you  can  see
easily what needs to be done to build it in a cross environment.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Most legends have their basis in facts.
	-- Kirk, "And The Children Shall Lead", stardate 5029.5
