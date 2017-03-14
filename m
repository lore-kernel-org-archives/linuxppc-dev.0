Return-Path: <harshal.patil@in.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vjBZb5xcSzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Mar 2017 21:59:35 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2EAwojP086846
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Mar 2017 06:59:24 -0400
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [125.16.236.9])
 by mx0a-001b2d01.pphosted.com with ESMTP id 296156vm7m-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Mar 2017 06:59:24 -0400
Received: from localhost
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <harshal.patil@in.ibm.com>;
 Tue, 14 Mar 2017 16:29:21 +0530
Received: from d50lp33.co.us.ibm.com (d50lp33.boulder.ibm.com [9.17.249.38])
 by d28relay07.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v2EAw7Fg14155804
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Mar 2017 16:28:08 +0530
Received: from localhost
 by d50lp33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <harshal.patil@in.ibm.com>;
 Tue, 14 Mar 2017 04:59:17 -0600
Received: from localhost
 by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
 for <linuxppc-dev@lists.ozlabs.org> from <harshal.patil@in.ibm.com>;
 Tue, 14 Mar 2017 10:59:15 -0000
Subject: Re: ioctl structs differ from x86_64?
In-Reply-To: <OF8A8205F0.34AB5FF3-ON002580E3.00393B30-002580E3.003A62F5@LocalDomain>
From: "Harshal Patil" <harshal.patil@in.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: "Sudipto Ghosh" <sudiptoghosh@in.ibm.com>, "Pradipta Kumar"
 <bpradipt@in.ibm.com>, "Christy L Norman Perez" <clnperez@us.ibm.com>
Date: Tue, 14 Mar 2017 10:59:12 +0000
MIME-Version: 1.0
References: <OF8A8205F0.34AB5FF3-ON002580E3.00393B30-002580E3.003A62F5@LocalDomain>
Content-Type: text/html; charset=UTF-8
Message-Id: <OFDC9753D5.25D6C64C-ON002580E3.003C5A05-002580E3.003C5A0F@notes.na.collabserv.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

<div class=3D"socmaildefaultfont" dir=3D"ltr" style=3D"font-family:Arial, H=
elvetica, sans-serif;font-size:10.5pt" ><div dir=3D"ltr" >Adding Pradipta a=
nd Christy.</div>
<div dir=3D"ltr" ><div class=3D"socmaildefaultfont" dir=3D"ltr" style=3D"fo=
nt-family:Arial;font-size:10.5pt" ><div class=3D"socmaildefaultfont" dir=3D=
"ltr" style=3D"font-family:Arial;font-size:10.5pt" ><div dir=3D"ltr" style=
=3D"margin-top: 20px;" ><div style=3D"font-size: 12pt; font-weight: bold; f=
ont-family: sans-serif; color: #7C7C5F;" >Harshal&nbsp;Patil</div>
<div style=3D"font-size: 8pt; font-family: sans-serif; margin-top: 10px;" >=
<div><span style=3D"font-weight: bold; color: #336699;" >E-mail: </span><a =
href=3D"mailto:harshal.patil@in.ibm.com" style=3D"color: #555" >harshal.pat=
il@in.ibm.com</a></div></div></div></div></div></div>
<div dir=3D"ltr" >&nbsp;</div>
<div dir=3D"ltr" >&nbsp;</div>
<blockquote data-history-content-modified=3D"1" data-history-expanded=3D"1"=
 dir=3D"ltr" style=3D"border-left:solid #aaaaaa 2px; margin-left:5px; paddi=
ng-left:5px; direction:ltr; margin-right:0px" >----- Original message -----=
<br>From: Harshal Patil/India/IBM<br>To: linuxppc-dev@lists.ozlabs.org<br>C=
c: Sudipto Ghosh/India/IBM@IBMIN<br>Subject: ioctl structs differ from x86=
=5F64?<br>Date: Tue, Mar 14, 2017 4:07 PM<br>&nbsp;
<div dir=3D"ltr" style=3D"font-family:Arial, Helvetica, sans-serif;font-siz=
e:10.5pt" ><div dir=3D"ltr" style=3D"font-family:Arial, Helvetica, sans-ser=
if;font-size:10.5pt" ><div dir=3D"ltr" >Hello,</div>
<div dir=3D"ltr" >&nbsp;</div>
<div dir=3D"ltr" >I am looking into a bug,&nbsp;<a href=3D"https://bugzilla=
.linux.ibm.com/show=5Fbug.cgi?id=3D152493" target=3D"=5Fblank" >https://bug=
zilla.linux.ibm.com/show=5Fbug.cgi?id=3D152493</a>&nbsp;( external mirror i=
s at,&nbsp;<a href=3D"https://github.com/opencontainers/runc/issues/1364" t=
arget=3D"=5Fblank" >https://github.com/opencontainers/runc/issues/1364</a>)=
&nbsp;</div>
<div dir=3D"ltr" >&nbsp;</div>
<div dir=3D"ltr" >Recently in runc&nbsp;code, they added this code&nbsp;<a =
href=3D"https://github.com/opencontainers/runc/commit/eea28f480db435dbef4a2=
75de9776b9934818b8c#diff-5f5c07d0cab3ce2086437d3d43c0d25fR155" target=3D"=
=5Fblank" >https://github.com/opencontainers/runc/commit/eea28f480db435dbef=
4a275de9776b9934818b8c#diff-5f5c07d0cab3ce2086437d3d43c0d25fR155</a>. As yo=
u can see they set -onlcr&nbsp;to get rid of \r (line no. 164). Golang,&nbs=
p;in which runc is written, doesn't have any bindings for ioctls. &nbsp;Thi=
s means you have to invoke C code directly (that's what they are doing ther=
e).</div>
<div dir=3D"ltr" >&nbsp;</div>
<div dir=3D"ltr" >Our guess is the ioctls in ppc64le differ than x86=5F64, =
and thats why the code which is clearing onclr bit (<a href=3D"https://gith=
ub.com/opencontainers/runc/commit/eea28f480db435dbef4a275de9776b9934818b8c#=
diff-5f5c07d0cab3ce2086437d3d43c0d25fR164" target=3D"=5Fblank" >https://git=
hub.com/opencontainers/runc/commit/eea28f480db435dbef4a275de9776b9934818b8c=
#diff-5f5c07d0cab3ce2086437d3d43c0d25fR164</a>) is failing on ppc64le but w=
orks fine on x86=5F64.&nbsp;</div>
<div dir=3D"ltr" >&nbsp;</div>
<div dir=3D"ltr" >Any pointers on the possible solution would be really hel=
pful.&nbsp;</div>
<div dir=3D"ltr" >&nbsp;</div>
<div dir=3D"ltr" >Thanks,</div>
<div dir=3D"ltr" ><div dir=3D"ltr" style=3D"font-family:Arial;font-size:10.=
5pt" ><div dir=3D"ltr" style=3D"font-family:Arial;font-size:10.5pt" ><div d=
ir=3D"ltr" style=3D"margin-top: 20px;" ><div style=3D"font-size: 12pt; font=
-weight: bold; font-family: sans-serif; color: #7C7C5F;" >Harshal&nbsp;Pati=
l</div>
<div style=3D"font-size: 8pt; font-family: sans-serif; margin-top: 10px;" >=
<div><span style=3D"font-weight: bold; color: #336699;" >E-mail: </span><a =
href=3D"mailto:harshal.patil@in.ibm.com" style=3D"color: #555" target=3D"=
=5Fblank" >harshal.patil@in.ibm.com</a></div></div></div></div></div></div>=
</div></div></blockquote>
<div dir=3D"ltr" >&nbsp;</div></div><BR>
