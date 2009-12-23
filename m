Return-Path: <itssivaguru@gmail.com>
Received: from mail-pz0-f201.google.com (mail-pz0-f201.google.com
	[209.85.222.201]) by ozlabs.org (Postfix) with ESMTP id 4CF18B7BF5
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Dec 2009 06:01:26 +1100 (EST)
Received: by pzk39 with SMTP id 39so3341714pzk.15
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Dec 2009 11:01:25 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <12604cb0912231058k58589125s14cfbf5e287c9fe2@mail.gmail.com>
References: <12604cb0912231057n2282ed22r45dd3c9c57ce8b02@mail.gmail.com>
	<12604cb0912231058k58589125s14cfbf5e287c9fe2@mail.gmail.com>
From: Sivaguru Perambalam <itssivaguru@gmail.com>
Date: Wed, 23 Dec 2009 12:01:05 -0700
Message-ID: <12604cb0912231101o2648fe62v64c85be1e8fadcc0@mail.gmail.com>
Subject: Problem setting up pktgen
To: linuxppc-dev@ozlabs.org
Content-Type: multipart/alternative; boundary=00504502cc2bfa4564047b69f272
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--00504502cc2bfa4564047b69f272
Content-Type: text/plain; charset=ISO-8859-1

>
>
> Hello ,
>
> I want to use pktgen to do some UDP tests .
> So I figured out that pktgen is built in the kernel I am using (2.6.32) and
> tried to use the bash script given in the internet .
>
> Script :
>
> #! /bin/sh
> rmmod pktgen
> cd /usr/src/kernels/linux-2.6.32/net/core
> insmod pktgen.ko
>
> PGDEV=/proc/net/pktgen/pg0
>  function pgset() {
>     local result
>     echo $1 > $PGDEV
>    result=`cat $PGDEV | fgrep "Result: OK:"`
>     if [ "$result" = "" ]; then
>          cat $PGDEV | fgrep Result:
>     fi
> }
>
> function pg() {
>     echo inject > $PGDEV
>     cat $PGDEV
> }
>
> pgset "odev eth0"
> pgset "dst 1.1.1.3"
>
>
> I get the following error message :
>
> ./ipg: line 11: /proc/net/pktgen/pg0: No such file or directory
> cat: /proc/net/pktgen/pg0: No such file or directory
> cat: /proc/net/pktgen/pg0: No such file or directory
> ./ipg: line 11: /proc/net/pktgen/pg0: No such file or directory
> cat: /proc/net/pktgen/pg0: No such file or directory
> cat: /proc/net/pktgen/pg0: No such file or directory
>
> I am running this as the 'root' user.
> I don't understand how exactly pktgen is informed about
> the Ethernet interfaces on the system.
>
> This is what I get for  ls /proc/net/pktgen/ ,
> kpktgend_0  kpktgend_1  kpktgend_2  kpktgend_3  kpktgend_4  kpktgend_5
>  kpktgend_6  kpktgend_7  pgctrl
>
>
> Please let me know , what is going wrong.
>
> Thanks !
>
>
>
>
>

--00504502cc2bfa4564047b69f272
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margi=
n:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex;"><div><div class=
=3D"h5"><div class=3D"gmail_quote"><br>Hello ,<div><br></div><div>I want to=
 use pktgen to do some UDP tests .</div>

<div>So I figured out that pktgen is built in the kernel I am using (2.6.32=
) and tried to use the bash script given in the internet .</div>
<div><br>
</div><div>Script :</div><div><div><br></div><div>#! /bin/sh</div><div>rmmo=
d pktgen</div><div>cd /usr/src/kernels/linux-2.6.32/net/core</div><div>insm=
od pktgen.ko</div><div><br></div><div>PGDEV=3D/proc/net/pktgen/pg0</div>


<div>
function pgset() {</div><div>=A0=A0 =A0local result</div><div>=A0=A0 =A0ech=
o $1 &gt; $PGDEV</div><div>=A0=A0 result=3D`cat $PGDEV | fgrep &quot;Result=
: OK:&quot;`</div><div>=A0=A0 =A0if [ &quot;$result&quot; =3D &quot;&quot; =
]; then</div><div>=A0=A0 =A0 =A0 =A0 cat $PGDEV | fgrep Result:</div>



<div>=A0=A0 =A0fi</div><div>}</div><div><br></div><div>function pg() {</div=
><div>=A0=A0 =A0echo inject &gt; $PGDEV</div><div>=A0=A0 =A0cat $PGDEV</div=
><div>}</div><div><br></div><div>pgset &quot;odev eth0&quot;</div><div>pgse=
t &quot;dst 1.1.1.3&quot;</div>



<div><br></div></div><div><br></div><div>I get the following error message =
:</div><div><br></div><div><div>./ipg: line 11: /proc/net/pktgen/pg0: No su=
ch file or directory</div><div>cat: /proc/net/pktgen/pg0: No such file or d=
irectory</div>



<div>cat: /proc/net/pktgen/pg0: No such file or directory</div><div>./ipg: =
line 11: /proc/net/pktgen/pg0: No such file or directory</div><div>cat: /pr=
oc/net/pktgen/pg0: No such file or directory</div><div>cat: /proc/net/pktge=
n/pg0: No such file or directory</div>



<div><br></div></div><div>I am running this as the &#39;root&#39; user.=A0<=
/div><div>I don&#39;t understand how exactly pktgen is informed about the=
=A0Ethernet=A0interfaces on the system.</div><div><br></div><div>This is wh=
at I get for=A0=A0ls /proc/net/pktgen/=A0,</div>



<div>kpktgend_0 =A0kpktgend_1 =A0kpktgend_2 =A0kpktgend_3 =A0kpktgend_4 =A0=
kpktgend_5 =A0kpktgend_6 =A0kpktgend_7 =A0pgctrl</div><div><br></div><div><=
br></div><div>Please let me know , what is going wrong.</div><div><br></div=
><div>Thanks !</div>



<div><br></div><div><br></div><div><br></div>
</div><br>
</div></div></blockquote></div><br>

--00504502cc2bfa4564047b69f272--
