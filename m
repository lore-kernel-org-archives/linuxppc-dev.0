Return-Path: <wmaxfield@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.174])
	by ozlabs.org (Postfix) with ESMTP id 6A68467BA4
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 22 Jul 2006 07:17:05 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id e2so1466532ugf
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 21 Jul 2006 14:17:04 -0700 (PDT)
Message-ID: <45a1b53e0607211410y196d76b4j1f9dc5c32014bc7a@mail.gmail.com>
Date: Fri, 21 Jul 2006 16:10:46 -0500
From: "Wade Maxfield" <wmaxfield@gmail.com>
To: "Steve Iribarne (GMail)" <netstv@gmail.com>
Subject: Re: stupid linker question....
In-Reply-To: <b4b98b690607211306rea34437gb05e84d24e8c66a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_124835_8864232.1153516246227"
References: <b4b98b690607211306rea34437gb05e84d24e8c66a@mail.gmail.com>
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

------=_Part_124835_8864232.1153516246227
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

gcc -Wa,-alhs -g main.c >main.cs

  will put interleaved code/assembly into main.cs file.

wade



On 7/21/06, Steve Iribarne (GMail) <netstv@gmail.com> wrote:
>
> I forgot the flag that generates a list file that has both assembly
> and c mixed in.
>
> Anyone?
>
> Thanks...
>
> -stv
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>

------=_Part_124835_8864232.1153516246227
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br>gcc -Wa,-alhs -g main.c &gt;main.cs<br><br>&nbsp; will put interleaved code/assembly into main.cs file.<br><br>wade<br><br>&nbsp; <br><br><div><span class="gmail_quote">On 7/21/06, <b class="gmail_sendername">Steve Iribarne (GMail)
</b> &lt;<a href="mailto:netstv@gmail.com">netstv@gmail.com</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">I forgot the flag that generates a list file that has both assembly
<br>and c mixed in.<br><br>Anyone?<br><br>Thanks...<br><br>-stv<br>_______________________________________________<br>Linuxppc-embedded mailing list<br><a href="mailto:Linuxppc-embedded@ozlabs.org">Linuxppc-embedded@ozlabs.org
</a><br><a href="https://ozlabs.org/mailman/listinfo/linuxppc-embedded">https://ozlabs.org/mailman/listinfo/linuxppc-embedded</a><br></blockquote></div><br>

------=_Part_124835_8864232.1153516246227--
