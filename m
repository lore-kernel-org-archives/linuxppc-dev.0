Message-ID: <000b01bffd59$e0c22600$0301a8c0@w9801>
From: "Dan" <dung_nguyen@smartstors.com>
To: "Linux PPC Mailing List" <linuxppc-embedded@lists.linuxppc.org>
Subject: processes management
Date: Thu, 3 Aug 2000 21:48:23 +0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Friends,

I am Dan Nguyen, I just work with Linux PCC.
Could you help me (if I am wrong, please show me
the right address mailling list, thanks!

 - How to check memory safe when running application?
- I want find the program look like check_mem, that I can
check usaged memory before and after running an application.
I feel /proc/infomem can not say me my application has leak
mem. I used mpr, but I want to know other tools.
- When does dynamic loaded library was removed from memory?
- Can we remove dynamic library on demand?
- How to check a specified dynamic lib stay on memory or not?
- I make a big program with many functions, it not fit on small
memory (my Embedded Linux only have 4 MB RAM and no swap),
I intend design it as follows:
 + main program will manage all function: main_app
 + Write each function as shared library (ex: f1.so, f2.so, ... fn.so)
 + If main program need that function, then it will loaded into memory.

 Now I don't know which way to best:
 1. link main_app and f1.so, f2.so, ... fn.so
 OR
 2. call explicit function in main_app.c, only using -ldl

 Thanks for your concerning.

Dan Nguyen


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
