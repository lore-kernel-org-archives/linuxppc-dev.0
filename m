MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Subject: Desesperatly looking for a intConnect() equivalent routine... 
Date: Mon, 28 Jun 2004 17:51:24 +0100
Message-ID: <85E6ED5B5EC32F439702305CC417E12D9E2A85@email.3il.fr>
From: =?Windows-1252?Q?Garcia_J=E9r=E9mie?= <GARCIAJ@3il.fr>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi everybody,
I have to do a vxworks migration to a linux environment.
In the original application we use the "intConnect" function described as below:

>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

timer_connect( ) - connect a user routine to the timer signal

SYNOPSIS

int timer_connect
    (
    timer_t     timerid, /* timer ID */
    VOIDFUNCPTR routine, /* user routine */
    int         arg      /* user argument */
    )

DESCRIPTION

 This routine sets the specified routine to be invoked with arg when fielding a signal indicated by the timer's evp signal number, or if evp is NULL, when fielding the default signal (SIGALRM).

The signal handling routine should be declared as:


    void my_handler
        (
        timer_t timerid,      /* expired timer ID */
        int arg               /* user argument    */
        )

<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

In order to get a very similar way of working, I'm using the POSIX interface. Unfortunately, the POSIX timers routines do not seem to offer routine similar as intConnect.

Does anyone would have a clue for a newbie in Linux ppc dev please??
Tks a lot !!

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
