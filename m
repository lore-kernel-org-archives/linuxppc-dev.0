Message-ID: <3BDE0FEB.1050206@waitaki.otago.ac.nz>
Date: Tue, 30 Oct 2001 15:26:51 +1300
From: Bryce McKinlay <bryce@waitaki.otago.ac.nz>
MIME-Version: 1.0
To: Sato Daisuke <densuke@fuga.jp>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: benh's kernel is unable to compile.
References: <uwv1d2a3n.wl@fuga.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Sato Daisuke wrote:

>Hi, there.
>
>I trying to make current benh's source(2.4.14-pre2-ben0/from
>rsync). But couldn't make.
>

Hi,

FYI I built 2.4.14-pre2-ben0 out of rsync about 2 hours ago and it seems
to be working. It does get some IDE errors about lost IRQs during bootup
that didn't happen with 2.4.13-ben0. Eventually it said "ide0: reset"
and now appears to be working normally. This is on a Powebook G4.

regards

Bryce.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
