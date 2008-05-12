Return-Path: <ramkumarj2000@gmail.com>
Received: from ti-out-0910.google.com (ti-out-0910.google.com [209.85.142.189])
	by ozlabs.org (Postfix) with ESMTP id 4C2FEDDE3A
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 12 May 2008 19:12:46 +1000 (EST)
Received: by ti-out-0910.google.com with SMTP id w7so871600tib.13
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 12 May 2008 02:12:44 -0700 (PDT)
Message-ID: <4f8c3030805120212r730ded9dv23dfcc29119ebfe5@mail.gmail.com>
Date: Mon, 12 May 2008 17:12:42 +0800
From: "Ramkumar J" <ramkumarj2000@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Compiling applications using cross compiler packs libc
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_4564_3637462.1210583564086"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_4564_3637462.1210583564086
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi All,

I am trying to execute a compiled simple stand-alone application (
TestApp_Memory.c compiled with gcc 4.1.0 cross compiler for ppc [ I have
installed this through crosstool on a Linux PC ] ) on the ML403 Board
instead of using the compiler-set provided by XPS. I tried many options (
like --static to gcc) to make the object file little as produced by the XPS
Compiler Set. I find that when static is provided, the glibc is also packed
up as a part of application though I never make any calls to the glibc
libraries. If I dont provide the --static, the gcc produces a code assuming
the library as shared and hence I get an interp section.
Is there any way to produce the code  with only the application and NOT the
glibc ( As XPS compilers does). Am I missing out something. Is there any
specific flags. I find even nodefaultlib does not work.

For Eg: This is another example I tried

int main()
{
    int a = 5;
    int b = 10;
    int c = 15;

    c = a + b;

    c += 12;

    return 0;
}

With --static compilation, size is about 500K for the above code though the
useful content is too less. objdump reveals unneccessary calls to the libc.
Any suggestions would be helpful.

Thanks and Regards,
Ramkumar

------=_Part_4564_3637462.1210583564086
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br>Hi All,<br><br>I am trying to execute a compiled simple stand-alone application ( TestApp_Memory.c compiled with gcc 4.1.0 cross compiler for ppc [ I have installed this through crosstool on a Linux PC ] ) on the ML403 Board instead of using the compiler-set provided by XPS. I tried many options ( like --static to gcc) to make the object file little as produced by the XPS Compiler Set. I find that when static is provided, the glibc is also packed up as a part of application though I never make any calls to the glibc libraries. If I dont provide the --static, the gcc produces a code assuming the library as shared and hence I get an interp section. <br>
Is there any way to produce the code&nbsp; with only the application and NOT the glibc ( As XPS compilers does). Am I missing out something. Is there any specific flags. I find even nodefaultlib does not work.<br><br>For Eg: This is another example I tried<br>
<br>int main()<br>{<br>&nbsp;&nbsp;&nbsp; int a = 5;<br>&nbsp;&nbsp;&nbsp; int b = 10;<br>&nbsp;&nbsp;&nbsp; int c = 15;<br><br>&nbsp;&nbsp;&nbsp; c = a + b;<br><br>&nbsp;&nbsp;&nbsp; c += 12;<br><br>&nbsp;&nbsp;&nbsp; return 0;<br>}<br><br>With --static compilation, size is about 500K for the above code though the useful content is too less. objdump reveals unneccessary calls to the libc.<br>
Any suggestions would be helpful.<br><br>Thanks and Regards,<br>Ramkumar<br><br><br><br><br>

------=_Part_4564_3637462.1210583564086--
