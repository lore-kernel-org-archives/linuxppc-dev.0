In-Reply-To: <20040402172954.TJGK1910.out010.verizon.net@outgoing.verizon.net>
References: <20040402172954.TJGK1910.out010.verizon.net@outgoing.verizon.net>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <BD32DDF7-86D0-11D8-BCE9-000A95B15278@aimsys.nl>
Cc: <linuxppc-embedded@lists.linuxppc.org>
From: Jaap-Jan Boor <jjboor@aimsys.nl>
Subject: Re: C++ Memory Requirements for PowerQUICC 1
Date: Mon, 5 Apr 2004 09:13:29 +0200
To: vze8n24y@verizon.net
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

It depends on your program and C++ code. You probably mention C++
libraries
because of templates. If you use a lot of different types (classes) and
STL,
a lot of templates will be instantiated for your types, which can
quickly increase
the size of your program(s) (not much unlike to macros in C).
In addition, if you abstract 'the bit' with class hierarchies, stream
io, etc.
instead of using builtin types like 'int' you can create big programs.

Jaap-Jan

On Apr 2, 2004, at 19:29, vze8n24y@verizon.net wrote:

>
> Hi:
>
> I would like to run C++ on a PowerQUICC I system that has 8 MB of RAM.
> I was told by a friend that this was not enough memory to run a C++
> program with the C++ libraries. Does anyone have experience with this?
>
> Regards,
>
> Bob Davis
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
