Return-Path: <mgessner@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.242])
	by ozlabs.org (Postfix) with ESMTP id 58EE1DDEE2
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Feb 2009 01:48:09 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id d14so732082and.39
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Feb 2009 06:48:06 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <d2b9ccd90902230503i4c2535d5lbd05b7ddeddf3192@mail.gmail.com>
References: <d2b9ccd90902222354o2e42db77h2f86fda45b5483b6@mail.gmail.com>
	<85a5c2010902230439n1096196dr519462513bc3910d@mail.gmail.com>
	<d2b9ccd90902230503i4c2535d5lbd05b7ddeddf3192@mail.gmail.com>
Date: Mon, 23 Feb 2009 09:48:06 -0500
Message-ID: <85a5c2010902230648m72b63eeds70b4e7a5ec4d8c51@mail.gmail.com>
Subject: Re: Problem with decrementer interrupt
From: Matt Gessner <mgessner@gmail.com>
To: sumedh tirodkar <sumedhtirodkar@gmail.com>
Content-Type: multipart/alternative; boundary=0016e6470b0829b22d04639717d4
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--0016e6470b0829b22d04639717d4
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On Mon, Feb 23, 2009 at 8:03 AM, sumedh tirodkar
<sumedhtirodkar@gmail.com>wrote:

> I am using PowerPC 7447A...I am trying to port SA-RTL on PowerPC...


What I said earlier was: You need to tell people what cpu you're using, what
linux kernel, etc etc etc.

Fine, we know the CPU.  What kernel are you using?  Is it ancient?

I doubt the information below is going to be useful...


>
> I am using
>
> bla <function_name>
>
> from the assembly code to call the function in C file...This i am
> doing from interrupt handler of the decrementer...
> If any more details are required, please let me know...
>

--0016e6470b0829b22d04639717d4
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Mon, Feb 23, 2009 at 8:03 AM, sumedh =
tirodkar <span dir=3D"ltr">&lt;<a href=3D"mailto:sumedhtirodkar@gmail.com">=
sumedhtirodkar@gmail.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmai=
l_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0p=
t 0pt 0.8ex; padding-left: 1ex;">
I am using PowerPC 7447A...I am trying to port SA-RTL on PowerPC...</blockq=
uote><div><br>What I said earlier was: You need to tell people what cpu you=
&#39;re using, what linux kernel, etc etc etc.<br><br>Fine, we know the CPU=
.&nbsp; What kernel are you using?&nbsp; Is it ancient?<br>
<br>I doubt the information below is going to be useful...<br>&nbsp;<br></d=
iv><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(20=
4, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><br>
I am using<br>
<br>
bla &lt;function_name&gt;<br>
<br>
from the assembly code to call the function in C file...This i am<br>
doing from interrupt handler of the decrementer...<br>
If any more details are required, please let me know...<br>
</blockquote></div><br>

--0016e6470b0829b22d04639717d4--
