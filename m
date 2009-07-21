Return-Path: <hongwoo7@gmail.com>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.244])
	by bilbo.ozlabs.org (Postfix) with ESMTP id DF7B7B708B
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 21 Jul 2009 10:16:06 +1000 (EST)
Received: by rv-out-0708.google.com with SMTP id f25so976157rvb.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 20 Jul 2009 17:16:05 -0700 (PDT)
Message-ID: <4A6508AD.6090207@gmail.com>
Date: Tue, 21 Jul 2009 09:15:41 +0900
From: HongWoo Lee <hongwoo7@gmail.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Simple question about powerpc kernel source.
References: <4A643219.3070004@gmail.com> <1248084158.30899.8.camel@pasglop>
In-Reply-To: <1248084158.30899.8.camel@pasglop>
Content-Type: multipart/alternative;
	boundary="------------010104040704080805020304"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------010104040704080805020304
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

-------- Original Message  --------
Subject: Re: Simple question about powerpc kernel source.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: HongWoo Lee <hongwoo7@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
Date: Mon Jul 20 2009 19:02:38 GMT+0900
> On Mon, 2009-07-20 at 18:00 +0900, HongWoo Lee wrote:
>   
>> Hi all,
>>
>> I have something to ask for the ppc kernel source.
>>
>> #define LOADADDR(rn,name)           \
>>     lis     rn,name##@highest;      \
>>     ori     rn,rn,name##@higher;    \
>>     rldicr  rn,rn,32,31;            \
>>     oris    rn,rn,name##@h;         \
>>     ori     rn,rn,name##@l
>>
>> Is ## used for concatenation. I'm not sure because it is just meaningless.
>> If so what on earth is the result of concatenating ?
>>
>> And is there a good reference to understand powerpc asm ?
>> I'm reading Power ISA, but I can't find @highest, @higher and ##.
>> It would be good to know the reference book.
>>     
>
> You already asked pretty much the same question with the subject "Simple
> question about powerpc asm" and it was already replied to.
>
> Cheers,
> Ben.
>
>
>   

Thank you, Ben.

First, I aleady understood about @highest, @higher, @h and @l.
For now, what I want to know is about "##" in the below code.

#define LOADADDR(rn,name)           \
    lis     rn,name##@highest;      \
    ori     rn,rn,name##@higher;    \
    rldicr  rn,rn,32,31;            \
    oris    rn,rn,name##@h;         \
    ori     rn,rn,name##@l


And I don't want to ask every detail.
So I want to know the manual or document which describes the detail.


Regards,
HongWoo.


--------------010104040704080805020304
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=UTF-8" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
-------- Original Message  --------<br>
Subject: Re: Simple question about powerpc kernel source.<br>
From: Benjamin Herrenschmidt <a class="moz-txt-link-rfc2396E" href="mailto:benh@kernel.crashing.org">&lt;benh@kernel.crashing.org&gt;</a><br>
To: HongWoo Lee <a class="moz-txt-link-rfc2396E" href="mailto:hongwoo7@gmail.com">&lt;hongwoo7@gmail.com&gt;</a><br>
Cc: <a class="moz-txt-link-abbreviated" href="mailto:linuxppc-dev@lists.ozlabs.org">linuxppc-dev@lists.ozlabs.org</a><br>
Date: Mon Jul 20 2009 19:02:38 GMT+0900 <br>
<blockquote cite="mid:1248084158.30899.8.camel@pasglop" type="cite">
  <pre wrap="">On Mon, 2009-07-20 at 18:00 +0900, HongWoo Lee wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">Hi all,

I have something to ask for the ppc kernel source.

#define LOADADDR(rn,name)           \
    lis     rn,name##@highest;      \
    ori     rn,rn,name##@higher;    \
    rldicr  rn,rn,32,31;            \
    oris    rn,rn,name##@h;         \
    ori     rn,rn,name##@l

Is ## used for concatenation. I'm not sure because it is just meaningless.
If so what on earth is the result of concatenating ?

And is there a good reference to understand powerpc asm ?
I'm reading Power ISA, but I can't find @highest, @higher and ##.
It would be good to know the reference book.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
You already asked pretty much the same question with the subject "Simple
question about powerpc asm" and it was already replied to.

Cheers,
Ben.


  </pre>
</blockquote>
<br>
Thank you, Ben. <br>
<br>
First, I aleady understood about @highest, @higher, @h and @l. <br>
For now, what I want to know is about "##" in the below code. <br>
<br>
<pre wrap="">#define LOADADDR(rn,name)           \
    lis     rn,name##@highest;      \
    ori     rn,rn,name##@higher;    \
    rldicr  rn,rn,32,31;            \
    oris    rn,rn,name##@h;         \
    ori     rn,rn,name##@l</pre>
<br>
And I don't want to ask every detail. <br>
So I want to know the manual or document which describes the detail. <br>
<br>
<br>
Regards, <br>
HongWoo. <br>
<br>
</body>
</html>

--------------010104040704080805020304--
