Return-Path: <wd@denx.de>
Received: from mailout03.sul.t-online.com (mailout03.sul.t-online.com
	[194.25.134.81]) by ozlabs.org (Postfix) with ESMTP id 6EFF667E40
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  2 Aug 2005 17:15:45 +1000 (EST)
To: "FCG WANG Baohua" <Baohua.WANG@alcatel-sbell.com.cn>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 02 Aug 2005 10:31:59 +0800."
	<A9DE2BAF233E444FA9C5E77A5825A01E8652FA@ydmail.sbell.com.cn>
Date: Tue, 02 Aug 2005 09:15:22 +0200
Sender: wd@denx.de
Message-Id: <20050802071522.AE98C353BF9@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Reply: Bad Magic Number when boot linux kernel with ppcboot
	(PPC860 board)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <A9DE2BAF233E444FA9C5E77A5825A01E8652FA@ydmail.sbell.com.cn> you wrote:
> 
> => bootm 0x180000
> ## Booting image at 00000000 ...
> Bad Magic Number
> =>

The funny thing is that you seem to enter "0x180000" but the  address
printed  is  00000000.  make  sure  you  have  no funny characters or
control keys in this number. Re-type  it  carefully.  Omit  the  "0x"
part, i. e. try a plain "bootm 180000'


Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Brontosaurus Principle: Organizations  can  grow  faster  than  their
brains  can manage them in relation to their environment and to their
own physiology: when this occurs, they are an endangered species.
                                                - Thomas K. Connellan
