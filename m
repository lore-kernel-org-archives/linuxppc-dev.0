Return-Path: <petermendham@computing.dundee.ac.uk>
Received: from mailex.computing.dundee.ac.uk (mailex.computing.dundee.ac.uk
	[134.36.36.15]) by ozlabs.org (Postfix) with ESMTP id 05E5767B8F
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 29 Nov 2006 03:12:55 +1100 (EST)
Message-ID: <456C6015.3000801@computing.dundee.ac.uk>
Date: Tue, 28 Nov 2006 16:13:09 +0000
From: Peter Mendham <petermendham@computing.dundee.ac.uk>
MIME-Version: 1.0
To: Magnus Hjorth <mh@omnisys.se>,  linuxppc-embedded@ozlabs.org
Subject: Re: RE : Using Linux on ML405: Some basic questions
References: <000001c712c4$8252e870$c900a8c0@CRESITTLAB>
	<456C14F0.5020103@computing.dundee.ac.uk>
	<456C4FBE.7040302@omnisys.se>
In-Reply-To: <456C4FBE.7040302@omnisys.se>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Magnus Hjorth wrote:
> Those messages come from the Linux bootloader/decompression code, you 
> can see the calls in arch/ppc/boot/simple/misc-embedded.c
>
Excellent, thank you.  It is all beginning to make sense now.  I see 
that this code also gives the ability to edit the command line over the 
serial link, something which was sucking up a whole 5 seconds of my boot 
time.  I might have a play with that :)

Thanks again, all the responses have been really useful.
-- Peter
