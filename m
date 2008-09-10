Return-Path: <sebastien.chretien.enseirb@gmail.com>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.226])
	by ozlabs.org (Postfix) with ESMTP id 07EBDDDF61
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Sep 2008 19:48:00 +1000 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so2629477rvb.9
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Sep 2008 02:47:58 -0700 (PDT)
Message-ID: <319b0ac50809100247n4d35c8acx498b8bc0295694cf@mail.gmail.com>
Date: Wed, 10 Sep 2008 11:47:57 +0200
From: "=?ISO-8859-1?Q?S=E9bastien_Chr=E9tien?="
	<sebastien.chretien.enseirb@gmail.com>
To: "Sergei Shtylyov" <sshtylyov@ru.mvista.com>
Subject: Re: IDE
In-Reply-To: <48C7942C.9020304@ru.mvista.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_3171_25948236.1221040077790"
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

------=_Part_3171_25948236.1221040077790
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

It is a common ide controller :
offset 0x0 Data
offset 0x1 error
offset 0x2 Sector count
offset 0x3 sector No
offset 0x4 Cylinder low
offset 0x5 Cylinder High
offset 0x6 Head
offset 0x7 status

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

------=_Part_3171_25948236.1221040077790
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

It is a common ide controller :<br>
offset 0x0 Data<br>
offset 0x1 error<br>
offset 0x2 Sector count<br>
offset 0x3 sector No<br>
offset 0x4 Cylinder low<br>
offset 0x5 Cylinder High<br>
offset 0x6 Head<br>
offset 0x7 status<br><br><div><span class=3D"gmail_quote">2008/9/10, Sergei=
 Shtylyov &lt;<a href=3D"mailto:sshtylyov@ru.mvista.com">sshtylyov@ru.mvist=
a.com</a>&gt;:</span><blockquote class=3D"gmail_quote" style=3D"border-left=
: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1e=
x;">
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

------=_Part_3171_25948236.1221040077790--
