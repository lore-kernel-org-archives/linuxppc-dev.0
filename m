Return-Path: <vijesh.vh@gmail.com>
Received: from rproxy.gmail.com (rproxy.gmail.com [64.233.170.195])
	by ozlabs.org (Postfix) with ESMTP id C98E167A6D
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 31 Mar 2005 13:41:37 +1000 (EST)
Received: by rproxy.gmail.com with SMTP id a36so512206rnf
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 Mar 2005 19:41:35 -0800 (PST)
Message-ID: <8e78982e05033019414ee1b5f2@mail.gmail.com>
Date: Thu, 31 Mar 2005 09:11:35 +0530
From: Vijesh VH <vijesh.vh@gmail.com>
To: linuxppc-embedded@ozlabs.org
In-Reply-To: <8e78982e050330194058a5daa6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <8e78982e050330194058a5daa6@mail.gmail.com>
Subject: Problem in Viewml why doing make
Reply-To: Vijesh VH <vijesh.vh@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,
  I downloaded the viewml0.23 from site and configured it with
microwindows0.90 and FLNX0.14(FLTK1.0.7). When i gave the command make
all i received the following messages. Can anyone help me in solving
the problem in viewml 0.23 as early as possible.

********************************************************************************
make[1]: Entering directory `/root/viewml/src'
if [ ! -s .build_depends ]; then make -f build_depends.mk force-depends; fi
make[2]: Entering directory `/root/viewml/src'
Generating dependancies for /root/viewml/src...
g++ -M -L/usr/include -INONE/include -I. -I../kdecore -I../kimgio
-I../kdeui -I../jscript -I/root/flnx-0.17 -I/root/flnx-0.17/FL
-I./fltk -I/root/microwindows-0.90/include -I/usr/include/microwin
-I/include -I/include/par -g --permissive -DNANOX -D_NANOX
-I/usr/X11R6/include `/usr/local/bin/libwww-config --cflags` html.cpp
htmlchain.cpp htmlclue.cpp htmldata.cpp htmlfont.cpp htmliter.cpp
htmltable.cpp htmltoken.cpp jscript.cpp htmlview.cpp htmlframe.cpp
htmlobj.cpp debug.cpp htmlform.cpp main.cpp http.cpp http_.cpp
../kdecore/kurl.cpp ../kdeui/kcursor.cpp fltk/qtimer.cpp
fltk/qobject.cpp fltk/qpainter.cpp fltk/qdrawutil.cpp fltk/qfont.cpp
fltk/qrect.cpp fltk/qregexp.cpp fltk/qstring.cpp fltk/kcharsets.cpp
fltk/qcolor.cpp fltk/qpixmap.cpp fltk/qfontinfo.cpp fltk/qwidget.cpp
fltk/history.cpp fltk/qscrollbar.cpp fltk/nxslider.cpp
fltk/nxscrollbar.cpp fltk/nxscroll.cpp >> .build_depends
make[2]: Leaving directory `/root/viewml/src'
make[1]: Leaving directory `/root/viewml/src'
make[1]: Entering directory `/root/viewml/src'
g++ -L/usr/include -INONE/include -I. -I../kdecore -I../kimgio
-I../kdeui -I../jscript -I/root/flnx-0.17 -I/root/flnx-0.17/FL
-I./fltk -I/root/microwindows-0.90/include -I/usr/include/microwin
-I/include -I/include/par -g --permissive -DNANOX -D_NANOX
-I/usr/X11R6/include `/usr/local/bin/libwww-config --cflags` -I.. -c
-o html.o html.cpp
In file included from /usr/include/c++/3.3.3/backward/algo.h:59,
                 from fltk/qstring.h:4,
                 from ../kdecore/kurl.h:31,
                 from html.cpp:24:
/usr/include/c++/3.3.3/backward/backward_warning.h:32:2: warning:
#warning This file includes at least one deprecated or antiquated
header. Please consider using one of the 32 headers found in section
17.4.1.2 of the C++ standard. Examples include substituting the <X>
header for the <X.h> header for C++ includes, or <sstream> instead of
the deprecated header <strstream.h>. To disable this warning use
-Wno-deprecated.
In file included from /usr/include/c++/3.3.3/bits/locale_facets.tcc:41,
                 from /usr/include/c++/3.3.3/locale:47,
                 from /usr/include/c++/3.3.3/bits/ostream.tcc:37,
                 from /usr/include/c++/3.3.3/ostream:535,
                 from /usr/include/c++/3.3.3/iostream:45,
                 from /usr/include/c++/3.3.3/backward/iostream.h:32,
                 from /usr/include/c++/3.3.3/backward/iterator.h:33,
                 from /usr/include/c++/3.3.3/backward/algobase.h:60,
                 from /usr/include/c++/3.3.3/backward/algo.h:60,
                 from fltk/qstring.h:4,
                 from ../kdecore/kurl.h:31,
                 from html.cpp:24:
/usr/include/c++/3.3.3/cmath:107: error: `acosf' not declared
/usr/include/c++/3.3.3/cmath:110: error: `asinf' not declared
/usr/include/c++/3.3.3/cmath:113: error: `atanf' not declared
/usr/include/c++/3.3.3/cmath:116: error: `atan2f' not declared
/usr/include/c++/3.3.3/cmath:119: error: `ceilf' not declared
/usr/include/c++/3.3.3/cmath:122: error: `coshf' not declared
/usr/include/c++/3.3.3/cmath:125: error: `expf' not declared
/usr/include/c++/3.3.3/cmath:128: error: `floorf' not declared
/usr/include/c++/3.3.3/cmath:131: error: `fmodf' not declared
/usr/include/c++/3.3.3/cmath:134: error: `frexpf' not declared
/usr/include/c++/3.3.3/cmath:137: error: `ldexpf' not declared
/usr/include/c++/3.3.3/cmath:140: error: `logf' not declared
/usr/include/c++/3.3.3/cmath:143: error: `log10f' not declared
/usr/include/c++/3.3.3/cmath:146: error: `modff' not declared
/usr/include/c++/3.3.3/cmath:149: error: `powf' not declared
/usr/include/c++/3.3.3/cmath:152: error: `sinhf' not declared
/usr/include/c++/3.3.3/cmath:155: error: `tanf' not declared
/usr/include/c++/3.3.3/cmath:158: error: `tanhf' not declared
/usr/include/c++/3.3.3/cmath: In function `float std::acos(float)':
/usr/include/c++/3.3.3/cmath:184: error: `acosf' undeclared in namespace `
   __gnu_cxx::__c99_binding'
/usr/include/c++/3.3.3/cmath: At global scope:
/usr/include/c++/3.3.3/cmath:190: error: `acos' not declared
/usr/include/c++/3.3.3/cmath: In function `long double std::acos(long double)':
/usr/include/c++/3.3.3/cmath:194: error: `::acosl' undeclared (first use here)
/usr/include/c++/3.3.3/cmath: At global scope:
/usr/include/c++/3.3.3/cmath:200: error: `asin' not declared
/usr/include/c++/3.3.3/cmath: In function `float std::asin(float)':
/usr/include/c++/3.3.3/cmath:204: error: `asinf' undeclared in namespace `
   __gnu_cxx::__c99_binding'
/usr/include/c++/3.3.3/cmath: In function `long double std::asin(long double)':
/usr/include/c++/3.3.3/cmath:212: error: `::asinl' undeclared (first use here)
/usr/include/c++/3.3.3/cmath: At global scope:
/usr/include/c++/3.3.3/cmath:218: error: `atan' not declared
/usr/include/c++/3.3.3/cmath: In function `float std::atan(float)':
/usr/include/c++/3.3.3/cmath:222: error: `atanf' undeclared in namespace `
   __gnu_cxx::__c99_binding'
/usr/include/c++/3.3.3/cmath: In function `long double std::atan(long double)':
/usr/include/c++/3.3.3/cmath:230: error: `::atanl' undeclared (first use here)
/usr/include/c++/3.3.3/cmath: At global scope:
/usr/include/c++/3.3.3/cmath:236: error: `atan2' not declared
/usr/include/c++/3.3.3/cmath: In function `float std::atan2(float, float)':
/usr/include/c++/3.3.3/cmath:240: error: `atan2f' undeclared in namespace `
   __gnu_cxx::__c99_binding'
/usr/include/c++/3.3.3/cmath: In function `long double std::atan2(long double,
   long double)':
/usr/include/c++/3.3.3/cmath:249: error: `::atan2l' undeclared (first use here)
/usr/include/c++/3.3.3/cmath: At global scope:
/usr/include/c++/3.3.3/cmath:256: error: `ceil' not declared
/usr/include/c++/3.3.3/cmath: In function `float std::ceil(float)':
/usr/include/c++/3.3.3/cmath:260: error: `ceilf' undeclared in namespace `
   __gnu_cxx::__c99_binding'
/usr/include/c++/3.3.3/cmath: In function `long double std::ceil(long double)':
/usr/include/c++/3.3.3/cmath:268: error: `::ceill' undeclared (first use here)
/usr/include/c++/3.3.3/cmath: At global scope:
/usr/include/c++/3.3.3/cmath:274: error: `cos' not declared
/usr/include/c++/3.3.3/cmath:284: error: `cosh' not declared
/usr/include/c++/3.3.3/cmath: In function `float std::cosh(float)':
/usr/include/c++/3.3.3/cmath:288: error: `coshf' undeclared in namespace `
   __gnu_cxx::__c99_binding'
/usr/include/c++/3.3.3/cmath: In function `long double std::cosh(long double)':
/usr/include/c++/3.3.3/cmath:296: error: `::coshl' undeclared (first use here)
/usr/include/c++/3.3.3/cmath: At global scope:
/usr/include/c++/3.3.3/cmath:302: error: `exp' not declared
/usr/include/c++/3.3.3/cmath: In function `float std::exp(float)':
/usr/include/c++/3.3.3/cmath:306: error: `expf' undeclared in namespace `
   __gnu_cxx::__c99_binding'
/usr/include/c++/3.3.3/cmath: In function `long double std::exp(long double)':
/usr/include/c++/3.3.3/cmath:314: error: `::expl' undeclared (first use here)
/usr/include/c++/3.3.3/cmath: At global scope:
/usr/include/c++/3.3.3/cmath:320: error: `fabs' not declared
/usr/include/c++/3.3.3/cmath:330: error: `floor' not declared
/usr/include/c++/3.3.3/cmath: In function `float std::floor(float)':
/usr/include/c++/3.3.3/cmath:334: error: `floorf' undeclared in namespace `
   __gnu_cxx::__c99_binding'
/usr/include/c++/3.3.3/cmath: In function `long double std::floor(long double)
   ':
/usr/include/c++/3.3.3/cmath:342: error: `::floorl' undeclared (first use here)
/usr/include/c++/3.3.3/cmath: At global scope:
/usr/include/c++/3.3.3/cmath:348: error: `fmod' not declared
/usr/include/c++/3.3.3/cmath: In function `float std::fmod(float, float)':
/usr/include/c++/3.3.3/cmath:352: error: `fmodf' undeclared in namespace `
   __gnu_cxx::__c99_binding'
/usr/include/c++/3.3.3/cmath: In function `long double std::fmod(long double,
   long double)':
/usr/include/c++/3.3.3/cmath:361: error: `::fmodl' undeclared (first use here)
/usr/include/c++/3.3.3/cmath: At global scope:
/usr/include/c++/3.3.3/cmath:368: error: `frexp' not declared
/usr/include/c++/3.3.3/cmath: In function `float std::frexp(float, int*)':
/usr/include/c++/3.3.3/cmath:372: error: `frexpf' undeclared in namespace `
   __gnu_cxx::__c99_binding'
/usr/include/c++/3.3.3/cmath: In function `long double std::frexp(long double,
   int*)':
/usr/include/c++/3.3.3/cmath:380: error: `::frexpl' undeclared (first use here)
/usr/include/c++/3.3.3/cmath: At global scope:
/usr/include/c++/3.3.3/cmath:387: error: `ldexp' not declared
/usr/include/c++/3.3.3/cmath: In function `float std::ldexp(float, int)':
/usr/include/c++/3.3.3/cmath:391: error: `ldexpf' undeclared in namespace `
   __gnu_cxx::__c99_binding'
/usr/include/c++/3.3.3/cmath: In function `long double std::ldexp(long double,
   int)':
/usr/include/c++/3.3.3/cmath:400: error: `::ldexpl' undeclared (first use here)
/usr/include/c++/3.3.3/cmath: At global scope:
/usr/include/c++/3.3.3/cmath:407: error: `log' not declared
/usr/include/c++/3.3.3/cmath: In function `float std::log(float)':
/usr/include/c++/3.3.3/cmath:411: error: `logf' undeclared in namespace `
   __gnu_cxx::__c99_binding'
/usr/include/c++/3.3.3/cmath: In function `long double std::log(long double)':
/usr/include/c++/3.3.3/cmath:419: error: `::logl' undeclared (first use here)
/usr/include/c++/3.3.3/cmath: At global scope:
/usr/include/c++/3.3.3/cmath:425: error: `log10' not declared
/usr/include/c++/3.3.3/cmath: In function `float std::log10(float)':
/usr/include/c++/3.3.3/cmath:429: error: `log10f' undeclared in namespace `
   __gnu_cxx::__c99_binding'
/usr/include/c++/3.3.3/cmath: In function `long double std::log10(long double)
   ':
/usr/include/c++/3.3.3/cmath:437: error: `::log10l' undeclared (first use here)
/usr/include/c++/3.3.3/cmath: At global scope:
/usr/include/c++/3.3.3/cmath:443: error: `modf' not declared
/usr/include/c++/3.3.3/cmath: In function `float std::modf(float, float*)':
/usr/include/c++/3.3.3/cmath:447: error: `modff' undeclared in namespace `
   __gnu_cxx::__c99_binding'
/usr/include/c++/3.3.3/cmath: In function `long double std::modf(long double,
   long double*)':
/usr/include/c++/3.3.3/cmath:461: error: `::modfl' undeclared (first use here)
/usr/include/c++/3.3.3/cmath: At global scope:
/usr/include/c++/3.3.3/cmath:482: error: `pow' not declared
/usr/include/c++/3.3.3/cmath: In function `float std::pow(float, float)':
/usr/include/c++/3.3.3/cmath:486: error: `powf' undeclared in namespace `
   __gnu_cxx::__c99_binding'
/usr/include/c++/3.3.3/cmath: In function `long double std::pow(long double,
   long double)':
/usr/include/c++/3.3.3/cmath:495: error: `::powl' undeclared (first use here)
/usr/include/c++/3.3.3/cmath: At global scope:
/usr/include/c++/3.3.3/cmath:514: error: `sin' not declared
/usr/include/c++/3.3.3/cmath:524: error: `sinh' not declared
/usr/include/c++/3.3.3/cmath: In function `float std::sinh(float)':
/usr/include/c++/3.3.3/cmath:528: error: `sinhf' undeclared in namespace `
   __gnu_cxx::__c99_binding'
/usr/include/c++/3.3.3/cmath: In function `long double std::sinh(long double)':
/usr/include/c++/3.3.3/cmath:536: error: `::sinhl' undeclared (first use here)
/usr/include/c++/3.3.3/cmath: At global scope:
/usr/include/c++/3.3.3/cmath:542: error: `sqrt' not declared
/usr/include/c++/3.3.3/cmath:552: error: `tan' not declared
/usr/include/c++/3.3.3/cmath: In function `float std::tan(float)':
/usr/include/c++/3.3.3/cmath:556: error: `tanf' undeclared in namespace `
   __gnu_cxx::__c99_binding'
/usr/include/c++/3.3.3/cmath: In function `long double std::tan(long double)':
/usr/include/c++/3.3.3/cmath:564: error: `::tanl' undeclared (first use here)
/usr/include/c++/3.3.3/cmath: At global scope:
/usr/include/c++/3.3.3/cmath:570: error: `tanh' not declared
/usr/include/c++/3.3.3/cmath: In function `float std::tanh(float)':
/usr/include/c++/3.3.3/cmath:574: error: `tanhf' undeclared in namespace `
   __gnu_cxx::__c99_binding'
/usr/include/c++/3.3.3/cmath: In function `long double std::tanh(long double)':
/usr/include/c++/3.3.3/cmath:582: error: `::tanhl' undeclared (first use here)
make[1]: *** [html.o] Interrupt
make: *** [viewml] Interrupt
*************************************************************************************************
I think the problem may with the c++include directory that i used.
 Help me please.
--
Thanks and Regards,
Vijesh V H


-- 
Thanks and Regards,
Vijesh V H
