Message-ID: <3E95622F.80902@tataelxsi.co.in>
Date: Thu, 10 Apr 2003 17:53:11 +0530
From: "Omanakuttan" <omanakuttan@tataelxsi.co.in>
MIME-Version: 1.0
To: Graf Alex <alex.graf@siemens.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: AW: parse error before `{', stray '\' in program
References: <791B3205DB661A42B4BFE5464A7D1D02010E44F4@chzugexch02.zug.ch.abatos.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> I would use Unix file formats if i can!
> The problem is: We have developers on Windows. They are working with the
> same library as we are. Visual Studio produce this f... <cr><lf> or ^M or
> \r\n. And we are generatin code from Rose. This cause the same problems.
> Visual Studio has no problems with \n, but if someone save the file with
> Visual Studio, the problem occurs. (The same is with Rose)
> gcc 3.2 on host has no problem with this <cr><lf>. Is there allready a cross
> compiler (ppc_8xx-gcc) with verision 3.2? Or how difficult is it to build a
> new compiler?
Why don't you use dos2unix command ?


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
