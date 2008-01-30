Return-Path: <barisa.kisku@gmail.com>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.232])
	by ozlabs.org (Postfix) with ESMTP id 62F16DDD0B
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 Jan 2008 14:42:51 +1100 (EST)
Received: by wx-out-0506.google.com with SMTP id h27so98812wxd.15
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 29 Jan 2008 19:42:49 -0800 (PST)
Message-ID: <80bb1bc60801291942w7f1e3bb4g70142e78eadbce28@mail.gmail.com>
Date: Wed, 30 Jan 2008 09:12:48 +0530
From: "Barisa Kisku" <barisa.kisku@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: which data structure keep IO information.
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_15320_29734066.1201664568710"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_15320_29734066.1201664568710
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,
I have to port one customised layer 2 protocol stack and  read, write system
call to access devices in linux-2.4.
At the moment  this is ported in UNIX SVR2/4 operating system.this protocol
uses some common data structure,
i.e "user" in unix srv2/4, which keeps information such as
      u_error = return errorn code
      u_base = base address for I/O
     u_count = bytes remaining for I/O
     u_arg = argument to current system call etc.

so i need to store these information in linux-2.4 implementation for
implementing read/write system calls.so what is/are
corresponding structure in linux-2.4.i went through task_struct, fs_struct,
files_struct etc., but couldn't relate it properly.

Please help me on this .

thanks and regards,
Barisa Kisku

------=_Part_15320_29734066.1201664568710
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,<br>I have to port one customised layer 2 protocol stack and&nbsp; read, write system call to access devices in linux-2.4.<br>At the moment&nbsp; this is ported in UNIX SVR2/4 operating system.this protocol uses some common data structure, <br>
i.e &quot;user&quot; in unix srv2/4, which keeps information such as <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u_error = return errorn code<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u_base = base address for I/O<br>&nbsp;&nbsp;&nbsp;&nbsp; u_count = bytes remaining for I/O<br>&nbsp;&nbsp;&nbsp;&nbsp; u_arg = argument to current system call etc.<br>
<br>so i need to store these information in linux-2.4 implementation for implementing read/write system calls.so what is/are <br>corresponding structure in linux-2.4.i went through task_struct, fs_struct, files_struct etc., but couldn&#39;t relate it properly.<br>
<br>Please help me on this .<br><br>thanks and regards,<br>Barisa Kisku<br><br><br><br><br>

------=_Part_15320_29734066.1201664568710--
