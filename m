Message-ID: <008d01c0c173$830f6d40$ef0fa8c0@mystore>
From: "Nguyen Xuan Hoang" <jerry.nguyen@serialsystem.com.sg>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: how to define a label burst align
Date: Mon, 9 Apr 2001 21:05:42 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi All,

I am asking about the trick of compiler. Is  there any way to declare label
at burst align address.

For example:

void func()
{
....
goto label;
label:
....
}

How to declare label at burst align address?

Thank for any advice
Jerry


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
