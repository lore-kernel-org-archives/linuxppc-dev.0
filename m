Return-Path: <mamsadegh@hotmail.com>
Received: from bay0-omc3-s14.bay0.hotmail.com (bay0-omc3-s14.bay0.hotmail.com
	[65.54.246.214]) by ozlabs.org (Postfix) with ESMTP id 5E33DDDF93
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 13 Apr 2007 02:08:32 +1000 (EST)
Message-ID: <BAY115-DAV135BF9CBE35CF183DD0AF3B25E0@phx.gbl>
From: "Mohammad Sadegh Sadri" <mamsadegh@hotmail.com>
Date: Thu, 12 Apr 2007 09:08:29 -0700
MIME-Version: 1.0
To: "Andrei Konovalov" <akonovalov@ru.mvista.com>
Subject: RE: HOTO start with linux 2.6.* and ML403
References: <BAY115-W21FFB4DA2861035BC20B77B25F0@phx.gbl>
In-Reply-To: <BAY115-W21FFB4DA2861035BC20B77B25F0@phx.gbl>
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-15"
Cc: Linux PPC Linux PPC <linuxppc-embedded@ozlabs.org>, miroslaw.dach@psi.ch
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

oh yes
completely correct andrei
i should have mention that , but i forgot.
thanks


-----Original Message-----
From:	"Andrei Konovalov" <akonovalov@ru.mvista.com>
Sent:	April 12, 2007 3:30 PM
To:	"Mohammad Sadegh Sadri" <mamsadegh@hotmail.com>
Cc:	"miroslaw.dach@psi.ch" <miroslaw.dach@psi.ch>, "Linux PPC Linux PPC" =
<linuxppc-embedded@ozlabs.org>
Subject:	Re: HOTO start with linux 2.6.* and ML403

Mohammad Sadegh Sadri wrote:
<snip>
> from all of the files generated there you will need just xparameters.h =
and xparameters_ml403.h and nothing more
> if using mvista source, you will not even need these two files the =
files available in the source are ok themselves

- they are OK if you use ML403 and the EDK reference design for this =
board.
   For custom FPGA configuration you should use the EDK generated =
xparameters_ml403.h (if you
   use EDK to build the bitstream).

Thanks,
Andrei
