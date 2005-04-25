Return-Path: <ejohnson@acdstar.com>
Received: from mail.acdstar.com (mail.acdstar.com [209.98.244.9])
	by ozlabs.org (Postfix) with ESMTP id 6400367A6C
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 26 Apr 2005 08:00:35 +1000 (EST)
Message-Id: <6.2.1.2.1.20050425163431.031d58b0@mail.int.acdstar.com>
Date: Mon, 25 Apr 2005 17:00:39 -0500
To: "Stephen Warren" <SWarren@nvidia.com>,
	<linuxppc-embedded@ozlabs.org>
From: "Eric N. Johnson (ACD)" <ejohnson@acdstar.com>
In-Reply-To: <DBFABB80F7FD3143A911F9E6CFD477B00688411F@hqemmail02.nvidia .com>
References: <DBFABB80F7FD3143A911F9E6CFD477B00688411F@hqemmail02.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Subject: RE: New MPC5200 Eratta/ATA Bugs
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

At 02:35 PM 4/25/2005, Stephen Warren wrote:
>Freescale have been working with us on a board work-around for the
>problem. This basically involves deriving a substitute ATA_ISOLATION
>signal from the regular ATA control signals, in some cases.

Are you able to share the circuit they've recommended?  Is it as simple as:
   ISOLATION = ((ATA_CS1 or ATA_IOR) and (ATA_CS0 or ATA_IOR))

This seems like it would be in violation of the setup and hold time 
requirements for the data bus.

I've been told there's a new silicon revision of the MPC5200 due sometime 
later in the year, but the date keeps getting pushed back.

Eric

------------------------------------
Eric Johnson, Electrical Engineer
Advanced Communication Design
   7901 12th Avenue South
   Bloomington, MN 55425
Ph: 952-854-4000  Fax: 952-854-5774
