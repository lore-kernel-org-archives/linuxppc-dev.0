Return-Path: <rbeims@gmail.com>
Received: from mail-fx0-f66.google.com (mail-fx0-f66.google.com
	[209.85.161.66]) by ozlabs.org (Postfix) with ESMTP id 9D85BB70E7
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Jan 2011 05:45:25 +1100 (EST)
Received: by fxm14 with SMTP id 14so4657004fxm.9
	for <linuxppc-dev@ozlabs.org>; Wed, 05 Jan 2011 10:45:23 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <AANLkTi=uvunJ-ZFVGHZZExgBaNL9Sh0uZ3OiiCrcPnx=@mail.gmail.com>
References: <AANLkTin5XTnDEu1BJUOeF0UWtfEpotW5Bq__i8g6U05h@mail.gmail.com>
	<4D24B725.2020300@evidence.eu.com>
	<AANLkTi=uvunJ-ZFVGHZZExgBaNL9Sh0uZ3OiiCrcPnx=@mail.gmail.com>
Date: Wed, 5 Jan 2011 16:45:23 -0200
Message-ID: <AANLkTimc0nu-YriLRvm1KSVKk0-Qz8J-DJgAwAUbf1Ep@mail.gmail.com>
Subject: Fwd: mpc880 linux-2.6.32 slow running processes
From: Rafael Beims <rbeims@gmail.com>
To: linuxppc-dev@ozlabs.org
Content-Type: multipart/alternative; boundary=20cf30433e3ab2443004991dc9e9
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--20cf30433e3ab2443004991dc9e9
Content-Type: text/plain; charset=ISO-8859-1

I forgot to copy the list, sorry...

---------- Forwarded message ----------
From: Rafael Beims <rbeims@gmail.com>
Date: Wed, Jan 5, 2011 at 4:43 PM
Subject: Re: mpc880 linux-2.6.32 slow running processes
To: michael <michael@evidence.eu.com>


Wow! That was fast!
I applied the patch and it worked very well. Now I can use the commands
normally.
I will be doing more tests in the next days, but it seems that my problem is
solved.

Is this patch already mainstream in newer kernel versions?

Thanks again,

Rafael Beims
rbeims@gmail.com
(41) 8873-7565
"What I hear, I forget. What I see, I remember. And what I do, I
understand."
- Chinese Proverb


On Wed, Jan 5, 2011 at 4:23 PM, michael <michael@evidence.eu.com> wrote:

>  Hi
>
> On 01/05/2011 07:09 PM, Rafael Beims wrote:
>
> Hello all,
> I'm working with an MPC880 board that is supposed to run linux-2.6.32. After
> some work, I could get the kernel up and running, mounting a rootfs via
> NFS.
> The problem that I'm facing now is that when I try to run any process (may
> be an ls, cat, or whatever), the response of the process is *very* slow
> (something like 10 to 20 seconds for a ls).
> Monitoring the network packets, I can see that the nfs protocol is exchanged
> just fine, but at some time it simply stops, starting again with a request
> from the board several seconds later.
> I'm thinking that the processor is running (something, I don't know what)
> for all this time before I can see requests coming from the board again. I
> pinged the board from the PC and during all this I can see the packets being
> answered.
>
>
>  Can you try this patch?
>
>  My question to all is, did anyone see something like this already? Besides
> that, what is the status of the linux kernel support for the 8xx platform?
> Is it being actively tested / used today? I ask this because it seems that
> all the information on the internet very aged (forum discussions from 2005
> and below mostly).
>
> Is there something that I can do to try to narrow the cause of the problem?
>
> Anyway, any help would be truly appreciated. Please excuse me if this is not
> the right place to ask this too.
>
> Thanks and best regards,
> Rafael Beimsrbeims@gmail.com
> (41) 8873-7565
> "What I hear, I forget. What I see, I remember. And what I do, I
> understand."
> - Chinese Proverb
>
>
>
> _______________________________________________
> Linuxppc-dev mailing listLinuxppc-dev@lists.ozlabs.orghttps://lists.ozlabs.org/listinfo/linuxppc-dev
>
>
>

--20cf30433e3ab2443004991dc9e9
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I forgot to copy the list, sorry...<div><br><div class=3D"gmail_quote">----=
------ Forwarded message ----------<br>From: <b class=3D"gmail_sendername">=
Rafael Beims</b> <span dir=3D"ltr">&lt;<a href=3D"mailto:rbeims@gmail.com">=
rbeims@gmail.com</a>&gt;</span><br>
Date: Wed, Jan 5, 2011 at 4:43 PM<br>Subject: Re: mpc880 linux-2.6.32 slow =
running processes<br>To: michael &lt;<a href=3D"mailto:michael@evidence.eu.=
com">michael@evidence.eu.com</a>&gt;<br><br><br>Wow! That was fast!<div>I a=
pplied the patch and it worked very well. Now I can use the commands normal=
ly.</div>
<div>I will be doing more tests in the next days, but it seems that my prob=
lem is solved.</div><div><br></div><div>
Is this patch already mainstream in newer kernel versions?</div><div><br></=
div><div>Thanks again,<div class=3D"im"><br clear=3D"all">Rafael Beims<br><=
a href=3D"mailto:rbeims@gmail.com" target=3D"_blank">rbeims@gmail.com</a><b=
r>(41) 8873-7565<br>
&quot;What I hear, I forget. What I see, I remember. And what I do, I under=
stand.&quot;<br>
- Chinese Proverb<br>
<br><br></div><div><div></div><div class=3D"h5"><div class=3D"gmail_quote">=
On Wed, Jan 5, 2011 at 4:23 PM, michael <span dir=3D"ltr">&lt;<a href=3D"ma=
ilto:michael@evidence.eu.com" target=3D"_blank">michael@evidence.eu.com</a>=
&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">


 =20
   =20
 =20
  <div text=3D"#000000" bgcolor=3D"#ffffff">
    <tt>Hi<br>
      <br>
    </tt><div>On 01/05/2011 07:09 PM, Rafael Beims wrote:
    <blockquote type=3D"cite">
      <pre>Hello all,
I&#39;m working with an MPC880 board that is supposed to run linux-2.6.32. =
After
some work, I could get the kernel up and running, mounting a rootfs via
NFS.
The problem that I&#39;m facing now is that when I try to run any process (=
may
be an ls, cat, or whatever), the response of the process is *very* slow
(something like 10 to 20 seconds for a ls).
Monitoring the network packets, I can see that the nfs protocol is exchange=
d
just fine, but at some time it simply stops, starting again with a request
from the board several seconds later.
I&#39;m thinking that the processor is running (something, I don&#39;t know=
 what)
for all this time before I can see requests coming from the board again. I
pinged the board from the PC and during all this I can see the packets bein=
g
answered.

</pre>
    </blockquote>
    </div><tt>Can you try this patch?<br>
      <br>
    </tt>
    <blockquote type=3D"cite"><div>
      <pre>My question to all is, did anyone see something like this alread=
y? Besides
that, what is the status of the linux kernel support for the 8xx platform?
Is it being actively tested / used today? I ask this because it seems that
all the information on the internet very aged (forum discussions from 2005
and below mostly).

Is there something that I can do to try to narrow the cause of the problem?

Anyway, any help would be truly appreciated. Please excuse me if this is no=
t
the right place to ask this too.

Thanks and best regards,
Rafael Beims
<a href=3D"mailto:rbeims@gmail.com" target=3D"_blank">rbeims@gmail.com</a>
(41) 8873-7565
&quot;What I hear, I forget. What I see, I remember. And what I do, I
understand.&quot;
- Chinese Proverb

</pre>
      </div><pre><fieldset></fieldset>
_______________________________________________
Linuxppc-dev mailing list
<a href=3D"mailto:Linuxppc-dev@lists.ozlabs.org" target=3D"_blank">Linuxppc=
-dev@lists.ozlabs.org</a>
<a href=3D"https://lists.ozlabs.org/listinfo/linuxppc-dev" target=3D"_blank=
">https://lists.ozlabs.org/listinfo/linuxppc-dev</a></pre>
    </blockquote>
    <br>
  </div>

</blockquote></div><br></div></div></div>
</div><br></div>

--20cf30433e3ab2443004991dc9e9--
