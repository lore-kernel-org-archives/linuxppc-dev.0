Return-Path: <diggskevin38@gmail.com>
Received: from mail-vx0-f179.google.com (mail-vx0-f179.google.com
	[209.85.220.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 36D59B6F18
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  6 Aug 2011 03:34:40 +1000 (EST)
Received: by vxh2 with SMTP id 2so1756681vxh.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 05 Aug 2011 10:34:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <F0034E2F-AAAD-4DAC-A35A-E532B05B3210@skynet.be>
References: <F0034E2F-AAAD-4DAC-A35A-E532B05B3210@skynet.be>
Date: Fri, 5 Aug 2011 12:34:36 -0500
Message-ID: <CAKTLLVQ3n-NvOhN0GhNiVcDpc6kJFHG9=80B9xOftD=0umydLQ@mail.gmail.com>
Subject: Re: MESH SCSI driver not working
From: kevin diggs <diggskevin38@gmail.com>
To: Pol Vangheluwe <pol.vangheluwe@skynet.be>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

I'll add some noise to this. I have a PowerMac8600 (with a 750GX in it
(in case that makes a difference)) and I can't boot 2.6.36 if it is
compiled with a gcc version newer than 4.1.2. Both 4.2.4 and 4.3.5
will hang. 4.1.2 seems ok.

kevin
