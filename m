From: Paul Mackerras <paulus@linuxcare.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <14735.25805.953473.825729@argo.linuxcare.com.au>
Date: Tue, 8 Aug 2000 11:39:25 +1000 (EST)
To: Gabriel Paubert <paubert@iram.es>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: rtc again... 
In-Reply-To: <Pine.HPX.4.10.10008071127140.9070-100000@gra-ux1.iram.es>
References: <200008041525.LAA30014@mal-ach.watson.ibm.com>
	<Pine.HPX.4.10.10008071127140.9070-100000@gra-ux1.iram.es>
Reply-To: paulus@linuxcare.com.au
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Gabriel Paubert writes:

> Hard reset also clears the timebase on all the processors I know, so the
> time bases should be synchronized unless the firmware plays with them
> (assuming the HRESET pins are wired together).

Certainly on my 7600 with a 2-cpu powersurge board, with the code that
is currently in the devel kernel to use the tb register, you don't get
the same time on both cpus.

I haven't had a chance to look at your patch in detail yet, hopefully
soon.  At a quick glance it seemed to be touching a lot of stuff so it
will take more than a quick glance. :-)

Paul.

--
Paul Mackerras, Senior Open Source Researcher, Linuxcare, Inc.
+61 2 6262 8990 tel, +61 2 6262 8991 fax
paulus@linuxcare.com.au, http://www.linuxcare.com.au/
Linuxcare.  Support for the revolution.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
