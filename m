Content-Type: text/plain;
  charset="iso-8859-1"
From: Ricardo Scop <scop@digitel.com.br>
To: kqtrinh@yahoo.com
Subject: Re: Fwd: linuxppc_2_4_devel tree
Date: Thu, 8 Aug 2002 16:23:38 -0300
References: <18659.020808@vanet.com.br>
In-Reply-To: <18659.020808@vanet.com.br>
Cc: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Message-Id: <02080816233800.01080@scop.digitel.com.br>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Khai,

Well, it should be:

rsync -avz --delete  source.mvista.com::linuxppc_2_4_devel <your_directory>

but I haven't tested it latelly. BTW, linuxppc_2_5 is now linuxppc-2.5
(_this_ I know for sure :-)

HTH,

Scop.

On Thursday 08 August 2002 15:49, you wrote:
>
> Hi folks,
>
> Can someone tell me what's the exact rsync syntax to
> obtain the source code from mvista rsync server?
>
> Thanks,
> --Khai
>
> HotJobs - Search Thousands of New Jobs
> http://www.hotjobs.com
>
>
>
> ===8<===========End of original message text===========

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
