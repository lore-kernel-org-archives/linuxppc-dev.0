Message-ID: <3E64EA95.7050405@paulidav.org>
Date: Tue, 04 Mar 2003 10:04:05 -0800
From: Vladimir Gurevich <vag@paulidav.org>
MIME-Version: 1.0
To: Omanakuttan <omanakuttan@tataelxsi.co.in>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: problem in ppc-linux-gcc cross compiler.
References: <3E64DC21.4060802@tataelxsi.co.in>
In-Reply-To: <3E64DC21.4060802@tataelxsi.co.in>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

You should change the line
>              warning, __FILE__, __LINE__, __FUNCTION__, ##msg) ;\
to
>              warning, __FILE__, __LINE__, __FUNCTION__ , ##msg) ;\

This space (after __FUNCTION__) will do the trick.

You can read more about it in gcc info file (C Extensions/Macro Varargs),
where the issue is thoroughly explained:

       This is a special feature of the GNU C preprocessor: `##' before a
       rest argument that is empty discards the preceding sequence of
       non-whitespace characters from the macro definition.  (If another
       macro argument precedes, none of it is discarded.)


Hope, this helps.
Vladimir


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
