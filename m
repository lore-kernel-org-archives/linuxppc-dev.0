Message-Id: <5.1.0.14.2.20030410094232.02cff008@mail.ebshome.net>
Date: Thu, 10 Apr 2003 09:47:39 -0700
To: Graf Alex <alex.graf@siemens.com>
From: Eugene Surovegin <ebs@ebshome.net>
Subject: Re: parse error before `{', stray '\' in program
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <791B3205DB661A42B4BFE5464A7D1D02010E44F3@chzugexch02.zug.c
 h.abatos.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


At 02:23 AM 4/10/2003, you wrote:

>The troubles are coming from the dos <cr><lf> at line end. With gcc 3.2
>(from host) I don't have this problems.
>I don't want to remove the <cr>s (dos2unix), because these files have to be
>used on Windows too.

There is an old patch (dated 1999) for preprocessor which solves this problem.
Search the net or use the distribution which has this patch applied e.g. MVL.

Eugene


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
