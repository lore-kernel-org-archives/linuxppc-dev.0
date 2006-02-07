Return-Path: <dan@embeddedalley.com>
Received: from smtp105.biz.mail.mud.yahoo.com (smtp105.biz.mail.mud.yahoo.com
	[68.142.200.253]) by ozlabs.org (Postfix) with SMTP id 5CD4A68A7B
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  8 Feb 2006 09:59:09 +1100 (EST)
In-Reply-To: <IUC8X2$BBAE28486C091C5CAA95431276FDABE5@libero.it>
References: <IUC8X2$BBAE28486C091C5CAA95431276FDABE5@libero.it>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <2b580ad2e66bb31541226d5353babedb@embeddedalley.com>
From: Dan Malek <dan@embeddedalley.com>
Subject: Re: MPC875 using SCC4 together with both FECs
Date: Tue, 7 Feb 2006 17:59:09 -0500
To: "dibacco\@inwind\.it" <dibacco@inwind.it>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Feb 7, 2006, at 5:24 PM, dibacco@@inwind..it wrote:

> Someone knows if, in MPC875, SCC4 can be used together with the two 
> FECs? I saw that RXD4(input SCC4) shares the same GPIO with MII-TXD0 
> (output of FEC0).

That's a correct observation, you can't do it.  I don't remember
and don't have documentation handy, but would it work in
RMII mode?  Otherwise, you will have to step up to the MPC870.


	-- Dan
