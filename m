Return-Path: <akonovalov@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id 5AE32DDF2F
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 13 Apr 2007 01:26:55 +1000 (EST)
Message-ID: <461E50B3.6060105@ru.mvista.com>
Date: Thu, 12 Apr 2007 19:30:59 +0400
From: Andrei Konovalov <akonovalov@ru.mvista.com>
MIME-Version: 1.0
To: Mohammad Sadegh Sadri <mamsadegh@hotmail.com>
Subject: Re: HOTO start with linux 2.6.* and ML403
References: <BAY115-W21FFB4DA2861035BC20B77B25F0@phx.gbl>
In-Reply-To: <BAY115-W21FFB4DA2861035BC20B77B25F0@phx.gbl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Mohammad Sadegh Sadri wrote:
<snip>
> from all of the files generated there you will need just xparameters.h and xparameters_ml403.h and nothing more
> if using mvista source, you will not even need these two files the files available in the source are ok themselves

- they are OK if you use ML403 and the EDK reference design for this board.
   For custom FPGA configuration you should use the EDK generated xparameters_ml403.h (if you
   use EDK to build the bitstream).

Thanks,
Andrei
