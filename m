From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
Reply-To: khendricks@ivey.uwo.ca
To: David Edelsohn <dje@watson.ibm.com>, khendricks@ivey.uwo.ca
Subject: Re: Issue with small struct return values
Date: Sat, 20 Jan 2001 21:54:26 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
Cc: Andy Johnson <andyj@mc.com>, linuxppc-dev@lists.linuxppc.org
References: <200101210245.VAA25704@mal-ach.watson.ibm.com>
In-Reply-To: <200101210245.VAA25704@mal-ach.watson.ibm.com>
MIME-Version: 1.0
Message-Id: <01012021542604.13943@localhost>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

Boy are we on different pages!

On Saturday 20 January 2001 21:45, David Edelsohn wrote:
> You asked about a stdarg extension.  That is what I have been
> discussing.
>

I thought you said that vararg changes were C standards issues and not GCC
issues.

So I have been asking about the process of the ABI change since you said you
could not impact on the decision to add a MACRO to hide our unique varargs.
I never wanted to change the varargs, I wanted a macro to hide passing
pointers and dereferencing va_lists.

It would make no sense to break the abi on vararg passing and then support
a change on returning small structures to support the abi.

I am interested in the process of if and when the abi change will be made
that Andy wants to make myself clearer.  Can you shed some light on this?

Kevin


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
