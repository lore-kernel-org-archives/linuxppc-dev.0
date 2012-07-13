Return-Path: <sarans1987@gmail.com>
Received: from mail-qc0-f179.google.com (mail-qc0-f179.google.com
 [209.85.216.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 60E682C033D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jul 2012 16:15:35 +1000 (EST)
Received: by qcse14 with SMTP id e14so2007338qcs.38
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jul 2012 23:15:32 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 13 Jul 2012 11:45:32 +0530
Message-ID: <CAEqOc-QpXcwbLuJXLbGv3VgccKnkMrdGV+ZdwFaFZCzjG3K7Mw@mail.gmail.com>
Subject: Standalone SRIO Driver for Linux
From: Saravanan S <sarans1987@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/alternative; boundary=20cf3074d3bceacb4104c4b00128
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--20cf3074d3bceacb4104c4b00128
Content-Type: text/plain; charset=ISO-8859-1

Hi ,
      Iam currently working on the GE make DSP230 board consisting of Quad
PowerPC8640 nodes   interconnected by SRIO with Linux 2.6.34 . However the
only way to access the SRIO is through rionet facility . Our requirement is
to use the SRIO interconnect without the Ethernet overheads. This would
definitely enable higher speeds (though I cant find any throughput figures
for SRIO in Linux on the net ??? ).  My query is that whether any attempt
has been made  to develop a  standalone driver and API to access the
messaging  and doorbell services of SRIO . If no then request you to please
provide inputs on the same. From my study I have the following thoughts for
the driver :

a) Have a character device interface for user .
b) Basically use the rio support functions provided in rio.c like
rio_add_inb_buffer ,  rio_add_outb_message to transfer and receive messages
and add buffers .
c) Maintain a dedicated ring of buffers in the driver and transfer  data to
and from the buffer to user space .


Is this the right direction . Would really appreciate any inputs . thanks
in advance.

Regards,

S.Saravanan

--20cf3074d3bceacb4104c4b00128
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi ,<br>=A0=A0=A0=A0=A0 Iam currently working on the GE make DSP230 board c=
onsisting of Quad PowerPC8640 nodes =A0 interconnected by SRIO with Linux 2=
.6.34 . However the only way to access the SRIO is through rionet facility =
. Our requirement is to use the SRIO interconnect without the Ethernet over=
heads. This would definitely enable higher speeds (though I cant find any t=
hroughput figures for SRIO in Linux on the net ??? ).=A0 My query is that w=
hether any attempt has been made=A0 to develop a=A0 standalone driver and A=
PI to access the messaging=A0 and doorbell services of SRIO . If no then re=
quest you to please provide inputs on the same. From my study I have the fo=
llowing thoughts for the driver :<br>
<br>a) Have a character device interface for user .<br>b) Basically use the=
 rio support functions provided in rio.c like=A0 rio_add_inb_buffer ,=A0 ri=
o_add_outb_message to transfer and receive messages and add buffers .<br>c)=
 Maintain a dedicated ring of buffers in the driver and transfer=A0 data to=
 and from the buffer to user space .<br>
<br><br>Is this the right direction . Would really appreciate any inputs . =
thanks in advance.<br><br>Regards,<br><br>S.Saravanan<br>

--20cf3074d3bceacb4104c4b00128--
