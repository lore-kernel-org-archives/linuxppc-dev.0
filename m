Message-ID: <3F26303D.1060101@dgt-lab.com.pl>
Date: Tue, 29 Jul 2003 10:28:45 +0200
From: Wojciech Kromer <krom@dgt-lab.com.pl>
MIME-Version: 1.0
To: "Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: /dev/random
References: <3F26160F.8060503@dgt-lab.com.pl>
In-Reply-To: <3F26160F.8060503@dgt-lab.com.pl>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


U¿ytkownik Wojciech Kromer napisa³:

>
> anyone has sucesses with /dev/random ?
> how to switch it to another sources (i do not have keyboard and mouse on
> my ebedded ppc platform)
>
> --

OK, i solved this quickly, just adding SA_SAMPLE_RANDOM flag in fec.c

--
* * * * * * * * * * * *
* per pedes ad astra! *
* * * * * * * * * * * *    mailto:krom@dgt-lab.com.pl


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
