Return-Path: <sebastien.chretien.enseirb@gmail.com>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.226])
	by ozlabs.org (Postfix) with ESMTP id 0CAFCDDDE6
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Sep 2008 19:34:09 +1000 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so2625019rvb.9
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Sep 2008 02:33:43 -0700 (PDT)
Message-ID: <319b0ac50809100233n4a4f50e8y77b408aa9955058b@mail.gmail.com>
Date: Wed, 10 Sep 2008 11:33:43 +0200
From: "=?ISO-8859-1?Q?S=E9bastien_Chr=E9tien?="
	<sebastien.chretien.enseirb@gmail.com>
To: "Sergei Shtylyov" <sshtylyov@ru.mvista.com>
Subject: Re: IDE
In-Reply-To: <48C7942C.9020304@ru.mvista.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_2943_14824774.1221039223094"
References: <319b0ac50809100224w2073359aod42c843cd5696599@mail.gmail.com>
	<48C7942C.9020304@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_2943_14824774.1221039223094
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Have I to rewrite a IDE driver ?

2008/9/10, Sergei Shtylyov <sshtylyov@ru.mvista.com>:
>
> Hello.
>
> S=E9bastien Chr=E9tien wrote:
>
>  I would like to setup my IDE controller. It uses a generic mapping. And =
he
>> is located at the adress 0x20003000.
>>
>
>  What kin of controller, and what do you mean by generic mapping?
>
>  How can I specifie this adress to the ide driver ?
>>
>
>  The usual ways is via the platform device.
>
>
> MBR, Sergei
>
>
>

------=_Part_2943_14824774.1221039223094
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Have I to rewrite a IDE driver ?<br><br><div><span class=3D"gmail_quote">20=
08/9/10, Sergei Shtylyov &lt;<a href=3D"mailto:sshtylyov@ru.mvista.com">ssh=
tylyov@ru.mvista.com</a>&gt;:</span><blockquote class=3D"gmail_quote" style=
=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; p=
adding-left: 1ex;">
Hello.<span class=3D"q"><br>
<br>
S=E9bastien Chr=E9tien wrote:<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
I would like to setup my IDE controller. It uses a generic mapping. And he =
is located at the adress 0x20003000.<br>
</blockquote>
<br></span>
 &nbsp;What kin of controller, and what do you mean by generic mapping?<spa=
n class=3D"q"><br>
<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
How can I specifie this adress to the ide driver ?<br>
</blockquote>
<br></span>
 &nbsp;The usual ways is via the platform device.<br>
<br>
<br>
MBR, Sergei<br>
<br>
<br>
</blockquote></div><br>

------=_Part_2943_14824774.1221039223094--
